
#ifndef VELODYNE_POINTCLOUD_VOXEL_GRID_H
#define VELODYNE_POINTCLOUD_VOXEL_GRID_H

#include <map>
#include <cfloat>

namespace velodyne_pointcloud {

typedef Eigen::Array<size_t, 4, 1> Array4size_t;

struct cloud_point_index_idx
{
    unsigned int idx;
    unsigned int cloud_point_index;

    cloud_point_index_idx(unsigned int idx_, unsigned int cloud_point_index_) :
        idx(idx_),
        cloud_point_index(cloud_point_index_) {}
    bool operator <(const cloud_point_index_idx &p) const { return (idx < p.idx); }
};

/** \brief Obtain the maximum and minimum points in 3D from a given point cloud.
 * \param[in] cloud the pointer to a pcl::PCLPointCloud2 dataset
 * \param[in] x_idx the index of the X channel
 * \param[in] y_idx the index of the Y channel
 * \param[in] z_idx the index of the Z channel
 * \param[out] min_pt the minimum data point
 * \param[out] max_pt the maximum data point
 */
void get_min_max_3d (const pcl::PCLPointCloud2 &cloud, int x_idx, int y_idx, int z_idx,
        Eigen::Vector4f &min_pt, Eigen::Vector4f &max_pt);

/** \brief Obtain the maximum and minimum points in 3D from a given point cloud.
 * \note Performs internal data filtering as well.
 * \param[in] cloud the pointer to a pcl::PCLPointCloud2 dataset
 * \param[in] x_idx the index of the X channel
 * \param[in] y_idx the index of the Y channel
 * \param[in] z_idx the index of the Z channel
 * \param[in] distance_field_name the name of the dimension to filter data along to
 * \param[in] min_distance the minimum acceptable value in \a distance_field_name data
 * \param[in] max_distance the maximum acceptable value in \a distance_field_name data
 * \param[out] min_pt the minimum data point
 * \param[out] max_pt the maximum data point
 * \param[in] limit_negative \b false if data \b inside of the [min_distance; max_distance] interval should be
 * considered, \b true otherwise.
 */
void get_min_max_3d (const pcl::PCLPointCloud2 &cloud, int x_idx, int y_idx, int z_idx,
        const std::string &distance_field_name, float min_distance, float max_distance,
        Eigen::Vector4f &min_pt, Eigen::Vector4f &max_pt, bool limit_negative = false);

/** \brief VoxelGrid assembles a local 3D grid over a given PointCloud, and downsamples + filters the data.
 *
 * The VoxelGrid class creates a *3D voxel grid* (think about a voxel
 * grid as a set of tiny 3D boxes in space) over the input point cloud data.
 * Then, in each *voxel* (i.e., 3D box), all the points present will be
 * approximated (i.e., *downsampled*) with their centroid. This approach is
 * a bit slower than approximating them with the center of the voxel, but it
 * represents the underlying surface more accurately.
 *
 * \author Radu B. Rusu, Bastian Steder, Radoslaw Cybulski
 * \ingroup filters
 */
class DuVoxelGrid {

public:
    /** \brief Empty constructor. */
    DuVoxelGrid () :
        _leaf_size (Eigen::Vector4f::Zero ()),
        _inverse_leaf_size (Eigen::Array4f::Zero ()),
        _downsample_all_data (true),
        _leaf_layout (),
        _min_b (Eigen::Vector4i::Zero ()),
        _max_b (Eigen::Vector4i::Zero ()),
        _div_b (Eigen::Vector4i::Zero ()),
        _divb_mul (Eigen::Vector4i::Zero ()),
        _filter_field_name (""),
        _filter_limit_min (-FLT_MAX),
        _filter_limit_max (FLT_MAX),
        _filter_limit_negative (false),
        _x_idx (-1),
        _y_idx (-1),
        _z_idx (-1),
        _field_sizes (0){
        }

    /** \brief Destructor. */
    virtual ~DuVoxelGrid () {
    }

    /** \brief Provide a pointer to the input dataset
     * \param cloud the const boost shared pointer to a PointCloud message
     */
    void set_input_cloud (const pcl::PCLPointCloud2 &cloud);

    /** \brief Get a pointer to the input point cloud dataset. */
    inline pcl::PCLPointCloud2 const get_input_cloud () {
        return (_input);
    }

    /** \brief Set the voxel grid leaf size.
     * \param[in] leaf_size the voxel grid leaf size
     */
    inline void
    set_leaf_size (const Eigen::Vector4f &leaf_size)
    {
        _leaf_size = leaf_size;
        // Avoid division errors
        if (_leaf_size[3] == 0) {
            _leaf_size[3] = 1;
        }
        // Use multiplications instead of divisions
        _inverse_leaf_size = Eigen::Array4f::Ones() / _leaf_size.array();
    }

    /** \brief Set the voxel grid leaf size.
     * \param[in] lx the leaf size for X
     * \param[in] ly the leaf size for Y
     * \param[in] lz the leaf size for Z
     */
    inline void
    set_leaf_size (float lx, float ly, float lz)
    {
        _leaf_size[0] = lx;
        _leaf_size[1] = ly;
        _leaf_size[2] = lz;
        // Avoid division errors
        if (_leaf_size[3] == 0) {
            _leaf_size[3] = 1;
        }
        // Use multiplications instead of divisions
        _inverse_leaf_size = Eigen::Array4f::Ones() / _leaf_size.array();
    }

    /** \brief Get the voxel grid leaf size. */
    inline Eigen::Vector3f
    get_leaf_size () { return (_leaf_size.head<3> ()); }

    /** \brief Set to true if all fields need to be downsampled, or false if just XYZ.
     * \param[in] downsample the new value (true/false)
     */
    inline void
    set_downsample_all_data (bool downsample) { _downsample_all_data = downsample; }

    /** \brief Get the state of the internal downsampling parameter (true if
     * all fields need to be downsampled, false if just XYZ).
     */
    inline bool
    get_downsample_all_data () { return (_downsample_all_data); }

    /** \brief Get the minimum coordinates of the bounding box (after
     * filtering is performed).
     */
    inline Eigen::Vector3i
    get_min_box_coordinates () { return (_min_b.head<3> ()); }

    /** \brief Get the minimum coordinates of the bounding box (after
     * filtering is performed).
     */
    inline Eigen::Vector3i
    get_max_box_coordinates () { return (_max_b.head<3> ()); }

    /** \brief Get the number of divisions along all 3 axes (after filtering
     * is performed).
     */
    inline Eigen::Vector3i
    get_nr_divisions () { return (_div_b.head<3>()); }

    /** \brief Get the multipliers to be applied to the grid coordinates in
     * order to find the centroid index (after filtering is performed).
     */
    inline Eigen::Vector3i
    get_division_multiplier () { return (_divb_mul.head<3>()); }

    /** \brief Returns the index in the resulting downsampled cloud of the specified point.
     * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering performed,
     * and that the point is inside the grid, to avoid invalid access (or use getGridCoordinates+getCentroidIndexAt)
     * \param[in] x the X point coordinate to get the index at
     * \param[in] y the Y point coordinate to get the index at
     * \param[in] z the Z point coordinate to get the index at
     */
    inline int
    get_centroid_index (float x, float y, float z)
    {
        return (_leaf_layout.at(
                (Eigen::Vector4i(static_cast<int>(floor(x * _inverse_leaf_size[0])),
                                 static_cast<int>(floor(y * _inverse_leaf_size[1])),
                                 static_cast<int>(floor(z * _inverse_leaf_size[2])),
                0) - _min_b).dot(_divb_mul)));
    }

    /** \brief Returns the layout of the leafs for fast access to cells relative to current position.
     * \note position at (i-min_x) + (j-min_y)*div_x + (k-min_z)*div_x*div_y holds the index of the element at coordinates (i,j,k) in the grid (-1 if empty)
     */
    inline std::vector<int>
    get_leaf_layout () { return (_leaf_layout); }

    /** \brief Returns the corresponding (i,j,k) coordinates in the grid of point (x,y,z).
     * \param[in] x the X point coordinate to get the (i, j, k) index at
     * \param[in] y the Y point coordinate to get the (i, j, k) index at
     * \param[in] z the Z point coordinate to get the (i, j, k) index at
     */
    inline Eigen::Vector3i
    get_grid_coordinates (float x, float y, float z)
    {
        return (Eigen::Vector3i(static_cast<int>(floor(x * _inverse_leaf_size[0])),
                static_cast<int>(floor(y * _inverse_leaf_size[1])),
                static_cast<int>(floor(z * _inverse_leaf_size[2]))));
    }

    /** \brief Returns the index in the downsampled cloud corresponding to a given set of coordinates.
     * \param[in] ijk the coordinates (i,j,k) in the grid (-1 if empty)
     */
    inline int
    get_centroid_index_at (const Eigen::Vector3i &ijk)
    {
        int idx = ((Eigen::Vector4i() << ijk, 0).finished() - _min_b).dot(_divb_mul);
        // this checks also if leaf_layout_.size () == 0 i.e. everything was computed as needed
        if (idx < 0 || idx >= static_cast<int>(_leaf_layout.size()))
        {
            //if (verbose)
            //  PCL_ERROR ("[pcl::%s::getCentroidIndexAt] Specified coordinate is outside grid bounds, or leaf layout is not saved, make sure to call setSaveLeafLayout(true) and filter(output) first!\n", getClassName ().c_str ());
            return (-1);
        }
        return (_leaf_layout[idx]);
    }

    /** \brief Provide the name of the field to be used for filtering data. In conjunction with  \a setFilterLimits,
     * points having values outside this interval will be discarded.
     * \param[in] field_name the name of the field that contains values used for filtering
     */
    inline void
    set_filter_field_name (const std::string &field_name)
    {
        _filter_field_name = field_name;
    }

    /** \brief Get the name of the field used for filtering. */
    inline std::string const
    get_filter_field_name ()
    {
        return (_filter_field_name);
    }

    /** \brief Set the field filter limits. All points having field values outside this interval will be discarded.
     * \param[in] limit_min the minimum allowed field value
     * \param[in] limit_max the maximum allowed field value
     */
    inline void
    set_filter_limits (const double &limit_min, const double &limit_max)
    {
        _filter_limit_min = limit_min;
        _filter_limit_max = limit_max;
    }

    /** \brief Get the field filter limits (min/max) set by the user. The default values are -FLT_MAX, FLT_MAX.
     * \param[out] limit_min the minimum allowed field value
     * \param[out] limit_max the maximum allowed field value
     */
    inline void
    get_filter_limits (double &limit_min, double &limit_max)
    {
        limit_min = _filter_limit_min;
        limit_max = _filter_limit_max;
    }

    /** \brief Set to true if we want to return the data outside the interval specified by setFilterLimits (min, max).
     * Default: false.
     * \param[in] limit_negative return data inside the interval (false) or outside (true)
     */
    inline void
    set_filter_limits_negative (const bool limit_negative)
    {
        _filter_limit_negative = limit_negative;
    }

    /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false).
     * \param[out] limit_negative true if data \b outside the interval [min; max] is to be returned, false otherwise
     */
    inline void
    get_filter_limits_negative (bool &limit_negative)
    {
        limit_negative = _filter_limit_negative;
    }

    /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false).
     * \return true if data \b outside the interval [min; max] is to be returned, false otherwise
     */
    inline bool
    get_filter_limits_negative ()
    {
        return (_filter_limit_negative);
    }


    /** \brief Downsample a Point Cloud using a voxelized grid approach
     * \param[out] output the resultant point cloud
     */
    void apply_filter (pcl::PCLPointCloud2 &output);

protected:

    /** \brief The input point cloud dataset. */
    pcl::PCLPointCloud2 _input;

    /** \brief The size of a leaf. */
    Eigen::Vector4f _leaf_size;

    /** \brief Internal leaf sizes stored as 1/leaf_size_ for efficiency reasons. */
    Eigen::Array4f _inverse_leaf_size;

    /** \brief Set to true if all fields need to be downsampled, or false if just XYZ. */
    bool _downsample_all_data;

    /** \brief The leaf layout information for fast access to cells relative
     * to current position
     */
    std::vector<int> _leaf_layout;

    /** \brief The x-y-z fields indices. */
    int _x_idx, _y_idx, _z_idx;

    /** \brief The minimum and maximum bin coordinates, the number of
     * divisions, and the division multiplier.
     */
    Eigen::Vector4i _min_b, _max_b, _div_b, _divb_mul;

    /** \brief The desired user filter field name. */
    std::string _filter_field_name;

    /** \brief The minimum allowed filter value a point will be considered from. */
    double _filter_limit_min;

    /** \brief The maximum allowed filter value a point will be considered from. */
    double _filter_limit_max;

    /** \brief Set to true if we want to return the data outside (\a filter_limit_min_;\a filter_limit_max_). Default: false. */
    bool _filter_limit_negative;

    /** \brief The size of each individual field. */
    std::vector<int> _field_sizes;
    //
    //    /** \brief Downsample a Point Cloud using a voxelized grid approach
    //      * \param[out] output the resultant point cloud
    //      */
    //    void applyFilter (pcl::PCLPointCloud2 &output);
};
}

#endif  //#ifndef VELODYNE_POINTCLOUD_VOXEL_GRID_H
