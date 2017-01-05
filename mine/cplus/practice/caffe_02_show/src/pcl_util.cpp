#include "pcl_util.h"

//#include <xlog.h>
#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <pcl/filters/crop_box.h>
#include <pcl/search/impl/kdtree.hpp>
#include <pcl/features/impl/normal_3d_omp.hpp>

using std::vector;

void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::VectorXf& centroid) {
    _get_pointcloud_centroid<Eigen::VectorXf>(cloud, centroid);
}

void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::VectorXd& centroid) {
    _get_pointcloud_centroid<Eigen::VectorXd>(cloud, centroid);
}

void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::Vector3f& centroid) {
    _get_pointcloud_centroid<Eigen::Vector3f>(cloud, centroid);
}

void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::Vector3d& centroid) {
    _get_pointcloud_centroid<Eigen::Vector3d>(cloud, centroid);
}

void get_pointcloud_bbox_2d(PointCloudConstPtr cloud, Eigen::MatrixXf& bb) {
    //bb.resize(2, 2);  //TODO: should we resize inside this function? -bo
    bb(0, 0) = FLT_MAX; // Small x.
    bb(1, 0) = FLT_MAX; // Small y.
    bb(0, 1) = -FLT_MAX; // Big x.
    bb(1, 1) = -FLT_MAX; // Big y.
    for (size_t i = 0; i < cloud->points.size(); ++i) {
        double x = cloud->points[i].x;
        double y = cloud->points[i].y;
        if (x < bb(0, 0)) {
            bb(0, 0) = x;
        }
        if (x > bb(0, 1)) {
            bb(0, 1) = x;
        }
        if (y < bb(1, 0)) {
            bb(1, 0) = y;
        }
        if (y > bb(1, 1)) {
            bb(1, 1) = y;
        }
    }
}

void get_pointcloud_bbox_3d(PointCloudConstPtr cloud, Eigen::MatrixXf& bb) {
    bb.resize(3, 2);
    bb(0, 0) = FLT_MAX; // Small x.
    bb(1, 0) = FLT_MAX; // Small y.
    bb(0, 1) = -FLT_MAX; // Big x.
    bb(1, 1) = -FLT_MAX; // Big y.
    bb(2, 0) = FLT_MAX;  // small z
    bb(2, 1) = -FLT_MAX; // Big z
    for (size_t i = 0; i < cloud->points.size(); ++i) {
        double x = cloud->points[i].x;
        double y = cloud->points[i].y;
        double z = cloud->points[i].z;
        if (x < bb(0, 0)) {
            bb(0, 0) = x;
        }
        if (x > bb(0, 1)) {
            bb(0, 1) = x;
        }
        if (y < bb(1, 0)) {
            bb(1, 0) = y;
        }
        if (y > bb(1, 1)) {
            bb(1, 1) = y;
        }
        if (z < bb(2, 0)) {
            bb(2, 0) = z;
        }
        if (z > bb(2, 1)) {
            bb(2, 1) = z;
        }
    }
}

bool get_pointcloud_minarea_bbox(
        const PointCloud& pc,
        BoundingCube* box,
        const int& min_num_points,
        const bool& verbose) {
    if (pc.size() <= static_cast<size_t>(min_num_points)) {
        return false;
    }
    std::vector<cv::Point2f> pts;
    float min_z = FLT_MAX;
    float max_z = -FLT_MAX;
    for (size_t i = 0; i < pc.size(); ++i) {
        pts.push_back(cv::Point2f (pc.points[i].x, pc.points[i].y));
        min_z = std::min(min_z, pc.points[i].z);
        max_z = std::max(max_z, pc.points[i].z);
    }

    // compute MinAreaRect
    cv::RotatedRect mar = cv::minAreaRect(pts);
    // adjust angle
    if (mar.size.width < mar.size.height) {
        mar.angle -= 90;
        float tmp = mar.size.width;
        mar.size.width = mar.size.height;
        mar.size.height = tmp;
    }
    if (verbose) {
        //XLOG(INFO) << "center = " << mar.center.x << " " << mar.center.y << std::endl;
        //XLOG(INFO) << "size = " << mar.size.height << " " << mar.size.width << std::endl;
        //XLOG(INFO) << "yaw = " << mar.angle << std::endl;
        //XLOG(INFO) << "height = " << max_z - min_z << std::endl;
    }
    box->x = mar.center.x;
    box->y = mar.center.y;
    box->z = (min_z + max_z) / 2.0;
    box->length = mar.size.width;
    box->width = mar.size.height;
    box->height = max_z - min_z;
    box->yaw = (M_PI*(mar.angle+180))/180;

    return true;
}

bool get_pointcloud_aligned_bbox(PointCloudConstPtr pc, BoundingCube& box, int min_num_points) {
    // no enough points to compute bounding box
    if (pc->size() <= static_cast<size_t>(min_num_points)) {
        Eigen::Vector4f centroid;
        pcl::compute3DCentroid(*pc, centroid);

        Eigen::MatrixXf range;
        get_pointcloud_bbox_3d(pc, range);

        box.trans_x = centroid.x();
        box.trans_y = centroid.y();
        box.trans_z = centroid.z();

        box.x = (range(0, 0) + range(0, 1) ) / 2.0;
        box.y = (range(1, 0) + range(1, 1) ) / 2.0;
        box.z = (range(2, 0) + range(2, 1) ) / 2.0;
        box.length = std::max( double(range(0, 1) - range(0, 0)), 1.e-3 );
        box.width = std::max( double(range(1, 1) - range(1, 0)), 1.e-3 );
        box.height = std::max( double(range(2, 1) - range(2, 0)), 1.e-3 );
        box.yaw = 0.f;

        return false;
    }

    // .1 orient the point cloud.
    PointCloudPtr pc_trans(new PointCloud());
    double yaw = orient_cloud(*pc, *pc_trans);
    // .2 get width, height
    Eigen::MatrixXf range;
    get_pointcloud_bbox_3d(pc_trans, range);
    // .3 transform center of box back
    Eigen::Vector3f center_pt = Eigen::Vector3f::Zero(3);
    center_pt(0) = (range(0, 0) + range(0, 1)) / 2.f;
    center_pt(1) = (range(1, 0) + range(1, 1)) / 2.f;
    center_pt(2) = (range(2, 0) + range(2, 1)) / 2.f;

    Eigen::Affine3f transform_inv = Eigen::Affine3f::Identity();
    transform_inv.rotate(Eigen::AngleAxisf(yaw, Eigen::Vector3f(0, 0, 1)));
    Eigen::Vector3f center_pt_rotated = transform_inv * center_pt;


    box.x = center_pt_rotated(0);
    box.y = center_pt_rotated(1);
    box.z = center_pt_rotated(2);
    box.length = range(0, 1) - range(0, 0);
    box.width = range(1, 1) - range(1, 0);
    box.height = range(2, 1) - range(2, 0);
    box.yaw = yaw;
    return true;
}

bool pointcloud_to_eigen(const PointCloud& cloud,
                         Eigen::MatrixXf* points,
                         Eigen::VectorXf* intensities) {

    if (points == NULL || intensities == NULL) {
        //XLOG(ERROR) << "Null pointer.";
        return false;
    }
    for (size_t i = 0; i < cloud.size(); ++i) {
        points->coeffRef(i, 0) = cloud.points[i].x;
        points->coeffRef(i, 1) = cloud.points[i].y;
        points->coeffRef(i, 2) = cloud.points[i].z;
        intensities->coeffRef(i) = cloud.points[i].intensity;
    }
    return true;
}

const int DEFAULT_ROW_NUM = 100;
const int DEFAULT_COL_NUM = 100;
const int DEFAULT_PPM = 20;

bool convert_to_cvmat(
        const PointCloud& pc,
        cv::Mat1b& img_resize,
        const std::string& view,
        int scale) {
    cv::Mat1b img = cv::Mat1f(DEFAULT_ROW_NUM, DEFAULT_COL_NUM);
    img = 0;
    if (!cloud_plane_projector(pc, img, view)) {
        return false;
    }
    cv::resize(img, img_resize, cv::Size(img.cols * scale, img.rows * scale), cv::INTER_NEAREST);
    return true;
}

bool cloud_plane_projector(const PointCloud& pc, cv::Mat1b& img, const std::string& view) {
    cv::Mat1f img1f = cv::Mat1f(DEFAULT_ROW_NUM, DEFAULT_COL_NUM);
    cv::Mat1f counts = cv::Mat1f(DEFAULT_ROW_NUM, DEFAULT_COL_NUM);
    img1f = 0;
    counts = 0;
    int u = 0;
    int v = 0;
    for (size_t i = 0; i < pc.points.size(); ++i) {
        Point pt = pc.points[i];
        if (view == "XY") {
            u = static_cast<int>(pt.x * DEFAULT_PPM + DEFAULT_ROW_NUM / 2);
            v = static_cast<int>(pt.y * DEFAULT_PPM + DEFAULT_COL_NUM / 2);
        } else if (view == "XZ") {
            v = static_cast<int>(pt.x * DEFAULT_PPM + DEFAULT_COL_NUM / 2);
            u = static_cast<int>(-pt.z * DEFAULT_PPM + DEFAULT_ROW_NUM / 2);
        } else if (view == "YZ") {
            v = static_cast<int>(pt.y * DEFAULT_PPM + DEFAULT_COL_NUM / 2);
            u = static_cast<int>(-pt.z * DEFAULT_PPM + DEFAULT_ROW_NUM / 2);
        } else {
            //XLOG(ERROR) << "Invalid view: " << view;
            return false;
        }
        if (u < 0 || u >= img1f.cols || v < 0 || v >= img1f.rows) continue;
        img1f(u, v) += pt.intensity;
        ++counts(u, v);
    }

    // Normalize.
    for (int v = 0; v < img1f.rows; ++v) {
        for (int u = 0; u < img1f.cols; ++u) {
            if (counts(v, u) > 0) {
                img1f(v, u) /= counts(v, u);
            }
        }
    }
    // Invert the background and frontground.
    img1f.convertTo(img, CV_8UC1, -1, 255);
    return true;
}

void cloud_demean(PointCloud& pc) {
    // Demean by using centroid.
    Eigen::Vector4f centroid;
    pcl::compute3DCentroid(pc, centroid);
    for (size_t i = 0; i < pc.size(); ++i) {
        pc.points[i].x -= centroid(0);
        pc.points[i].y -= centroid(1);
        pc.points[i].z -= centroid(2);
    }
}

void cloud_demean(const PointCloud& pc, PointCloud& pc_demean) {
    // Demean by using centroid.
    Eigen::Vector4f centroid;
    pcl::compute3DCentroid(pc, centroid);
    pcl::demeanPointCloud(pc, centroid, pc_demean);
}

void cloud_demean(const Eigen::VectorXf& centroid, PointCloud& pc) {
    // Demean by using centroid.
    for (size_t i = 0; i < pc.size(); ++i) {
        pc.points[i].x -= centroid(0);
        pc.points[i].y -= centroid(1);
        pc.points[i].z -= centroid(2);
    }
}

bool find_dominant_direction_xy(const PointCloud& pc, Eigen::VectorXf& coeff) {
    PointCloudPtr pc_xy(new PointCloud());
    pc_xy->reserve(pc.points.size());
    // Project the cloud on XY plane.
    for (size_t i = 0; i < pc.points.size(); ++i) {
        Point pt = pc.points[i];
        pt.z = 0;
        pc_xy->push_back(pt);
    }
    // Create a shared plane model pointer directly
    pcl::SampleConsensusModelLine<Point>::Ptr line
        (new pcl::SampleConsensusModelLine<Point>(pc_xy));
    // Create the RANSAC object
    pcl::RandomSampleConsensus<Point> sac(line, 0.1);
    // perform the segmenation step
    if (!sac.computeModel()) {
        //XLOG(ERROR) << "Failed to compute model for RandomSampleConsensus.";
        return false;
    }
    sac.getModelCoefficients(coeff);
    /*
    std::vector<int> inliers;
    sac.getInliers(inliers);
    Eigen::VectorXf raw_coefs;
    sac.getModelCoefficients(raw_coefs);
    line->optimizeModelCoefficients(inliers, raw_coefs, coeff);
     */
    return true;
}

bool crop_image(const cv::Mat1b& src, cv::Mat1b& img) {
    cv::Rect roi;
    double width_pct = 1.0;
    double height_pct = 1.0;
    roi.width = src.cols * width_pct;
    roi.height = src.rows * height_pct;

    // -- Get min and max, with a small buffer.
    int min_u = src.cols - 1;
    int max_u = 0;
    int min_v = src.rows - 1;
    int max_v = 0;
    for (int v = 0; v < src.rows; ++v) {
        for (int u = 0; u < src.cols; ++u) {
            if (src(v, u) < 255) {
                min_u = cv::min(u, min_u);
                max_u = cv::max(u, max_u);
                min_v = cv::min(v, min_v);
                max_v = cv::max(v, max_v);
            }
        }
    }

    int buffer = 2;
    min_u = cv::max(min_u - buffer, 0);
    min_v = cv::max(min_v - buffer, 0);
    max_u = cv::min(max_u + buffer, src.cols - 1);
    max_v = cv::min(max_v + buffer, src.rows - 1);

    // -- Determine the roi position in the source image
    //    based on where the image is not zero.
    std::string va = "Center";
    if (va == "Top") {
        roi.y = cv::min(min_v, src.rows - roi.height);
    } else if (va == "Center") {
        roi.y = src.rows / 2 - roi.height / 2;
    } else if (va == "Bottom") {
        roi.y = cv::max(max_v - roi.height, 0);
    } else {
        //XLOG(ERROR) << "Invalid y position: " << va;
        return false;
    }

    std::string ha = "Left";
    if (ha == "Left") {
        roi.x = cv::min(min_u, src.cols - roi.width);
    } else if (ha == "Center") {
        roi.x = src.cols / 2 - roi.width / 2;
    } else if (ha == "Right") {
        roi.x = cv::max(max_u - roi.width, 0);
    } else {
        //XLOG(ERROR) << "Invalid x position: " << ha;
        return false;
    }
    // -- Copy and resize.
    cv::Mat window = src(roi);
    cv::resize(window, img, img.size(), 0, 0, cv::INTER_NEAREST);
    return true;
}

double orient_cloud(const PointCloud& pc, PointCloud& pc_out, bool demean) {
    // Approach#1:
    // Find car dominant direction on XY plane.
    /*Eigen::VectorXf coeff;
    find_dominant_direction_xy(pc, coeff);
    // This theta has ambiguity. To calculate the true heading,
    // we need to consider both obstacle's velocity direction and
    // robot's current velocity direction.
    double theta = atan2(coeff[4], coeff[3]);*/

    // Approach#2:
    // Use Minimum Area Bounding Box
    BoundingCube bbox;
    get_pointcloud_minarea_bbox(pc, &bbox);
    double theta = bbox.yaw;

    Eigen::Affine3f transform = Eigen::Affine3f::Identity();
    transform.rotate(Eigen::AngleAxisf(-theta, Eigen::Vector3f(0, 0, 1)));
    pcl::transformPointCloud(pc, pc_out, transform);
    if (demean) {
        cloud_demean(pc_out);
    }
    return theta;
}

double orient_cloud(const PointCloud& pc, PointCloud& pc_out, BoundingCube *bbox, bool demean) {
    // Approach#1:
    // Find car dominant direction on XY plane.
    /*Eigen::VectorXf coeff;
    find_dominant_direction_xy(pc, coeff);
    // This theta has ambiguity. To calculate the true heading,
    // we need to consider both obstacle's velocity direction and
    // robot's current velocity direction.
    double theta = atan2(coeff[4], coeff[3]);*/

    // Approach#2:
    // Use Minimum Area Bounding Box
    get_pointcloud_minarea_bbox(pc, bbox);
    double theta = bbox->yaw;

    Eigen::Affine3f transform = Eigen::Affine3f::Identity();
    transform.rotate(Eigen::AngleAxisf(-theta, Eigen::Vector3f(0, 0, 1)));
    pcl::transformPointCloud(pc, pc_out, transform);
    if (demean) {
        cloud_demean(pc_out);
    }
    return theta;
}


double normalize_cloud_matrix(const Eigen::MatrixXf& cloud, Eigen::MatrixXf& out_cloud) {
    Eigen::MatrixXf X = cloud;
    X.col(2) = Eigen::VectorXf::Zero(cloud.rows());
    // -- Subtract off the mean of the points.
    Eigen::VectorXf pt_mean = X.colwise().sum() / (float) X.rows();
    for (int i = 0; i < cloud.rows(); ++i) {
        X.row(i) -= pt_mean.transpose();
    }
    Eigen::MatrixXf Xt = X.transpose();
    Eigen::MatrixXf cov_mat = Xt * X;
    Eigen::SelfAdjointEigenSolver<Eigen::MatrixXf> es(cov_mat);
    Eigen::MatrixXf basis = Eigen::MatrixXf::Identity(3, 3);
    basis.col(0) = es.eigenvectors().col(2);
    basis.col(1) = es.eigenvectors().col(1);
    out_cloud = cloud * basis;
    double theta = atan2(basis(1, 0), basis(0, 0));
    return theta;
}

void crop_point_cloud(
        PointCloudConstPtr pc,
        const Eigen::Vector4f& maxPoint,
        const Eigen::Vector4f& minPoint,
        const Eigen::Vector3f& boxTranslation,
        const Eigen::Vector3f& boxRotation,
        PointCloud::Ptr pccrop,
        PointIndicesPtr pi) {

    bool extract_remove_indices = false;
    if (pi) {
        extract_remove_indices = true;
    }

    pcl::CropBox<Point> cropFilter(extract_remove_indices);
    cropFilter.setInputCloud(pc);
    cropFilter.setMin(minPoint);
    cropFilter.setMax(maxPoint);
    cropFilter.setTranslation(boxTranslation);
    cropFilter.setRotation(boxRotation);
    cropFilter.filter(*pccrop);

    if (pi) {
        cropFilter.getRemovedIndices(*pi);
    }
}

void extract_vfh(PointCloudConstPtr cloud, Eigen::VectorXf* desc) {
    assert(cloud);
    assert(desc && desc->rows() == 308);
    pcl::NormalEstimationOMP<Point, pcl::Normal> normalEstimation;
    pcl::search::KdTree<Point>::Ptr kdtree(new pcl::search::KdTree<Point>());

    // Estimate the normals.
    pcl::PointCloud<pcl::Normal>::Ptr normals(new pcl::PointCloud<pcl::Normal>);
    normalEstimation.setInputCloud(cloud);
    normalEstimation.setRadiusSearch(0.7);
    normalEstimation.setSearchMethod(kdtree);
    normalEstimation.compute(*normals);

    // Object for storing the VFH descriptor.
    pcl::PointCloud<pcl::VFHSignature308>::Ptr descriptor(
            new pcl::PointCloud<pcl::VFHSignature308>);
    // VFH estimation object.
    pcl::VFHEstimation<Point, pcl::Normal, pcl::VFHSignature308> vfh;
    vfh.setInputCloud(cloud);
    vfh.setInputNormals(normals);
    vfh.setSearchMethod(kdtree);
    vfh.setNormalizeBins(true);
    vfh.compute(*descriptor);
    memcpy(desc->data(), (float*)(&(descriptor->points[0])), 308 * sizeof(float));
}

void extract_VFH(PointCloudConstPtr cloud, Eigen::VectorXf* vfh) {
    extract_vfh(cloud, vfh);
}

void merge_point_indices(
       unsigned pointcloud_size,
       const vector<PointIndices>& indices_vec,
       bool is_and,
       PointIndices* out_vec) {
    int cnt_roi = static_cast<int>(indices_vec.size());

    vector<char> result_indices(pointcloud_size, 0);
    for (const auto& item_indices : indices_vec) {
        const auto& indices = item_indices.indices;
        for (const auto& item : indices) {
            ++result_indices[item];
        }
    }

    auto& temp_indices = out_vec->indices;
    temp_indices.reserve(pointcloud_size);
    for (size_t idx = 0; idx < pointcloud_size; ++idx) {
        if (is_and && (result_indices[idx] == cnt_roi)) {
            temp_indices.push_back(idx);
        }
        if (!is_and && (result_indices[idx] != 0)) {
            temp_indices.push_back(idx);
        }
    }
}

void filter_pointcloud(
        const vector<PointIndices>& roi_indices_vec,
        bool is_and,
        PointCloudPtr* pc_ptrptr) {
    PointCloudPtr& pc_ptr = *pc_ptrptr;
    const size_t pc_size = pc_ptr->size();

    PointIndices target_indices;
    merge_point_indices(pc_size, roi_indices_vec, is_and, &target_indices);

    pc_ptr.reset(new PointCloud(*pc_ptr, target_indices.indices));
}

