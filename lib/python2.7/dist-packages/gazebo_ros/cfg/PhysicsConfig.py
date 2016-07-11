## *********************************************************
## 
## File autogenerated for the gazebo_ros package 
## by the dynamic_reconfigure package.
## Please do not edit.
## 
## ********************************************************/

from dynamic_reconfigure.encoding import extract_params

inf = float('inf')

config_description = {'upper': 'DEFAULT', 'lower': 'groups', 'srcline': 235, 'name': 'Default', 'parent': 0, 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'cstate': 'true', 'parentname': 'Default', 'class': 'DEFAULT', 'field': 'default', 'state': True, 'parentclass': '', 'groups': [], 'parameters': [{'srcline': 280, 'description': 'Simulation world time step size in seconds, smaller time steps producesslower, more stable simulation.', 'max': 10.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'time_step', 'edit_method': '', 'default': 0.001, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'Simulator max update rate, -1 unlimited, 1 restricts to real-time if possible.', 'max': 1000.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'max_update_rate', 'edit_method': '', 'default': 60.0, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'Simulated gravity in the x direction.', 'max': 100.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'gravity_x', 'edit_method': '', 'default': 0.0, 'level': 1, 'min': -100.0, 'type': 'double'}, {'srcline': 280, 'description': 'Simulated gravity in the y direction.', 'max': 100.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'gravity_y', 'edit_method': '', 'default': 0.0, 'level': 1, 'min': -100.0, 'type': 'double'}, {'srcline': 280, 'description': 'Simulated gravity in the z direction.', 'max': 100.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'gravity_z', 'edit_method': '', 'default': -9.8, 'level': 1, 'min': -100.0, 'type': 'double'}, {'srcline': 280, 'description': "Auto disable of bodies in simulation if body it's not moving.", 'max': True, 'cconsttype': 'const bool', 'ctype': 'bool', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'auto_disable_bodies', 'edit_method': '', 'default': False, 'level': 1, 'min': False, 'type': 'bool'}, {'srcline': 280, 'description': 'Number of preconditioning iterations for SOR PGS LCP as implemented in quickstep.', 'max': 10000, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'sor_pgs_precon_iters', 'edit_method': '', 'default': 0, 'level': 1, 'min': 0, 'type': 'int'}, {'srcline': 280, 'description': 'Number of iterations for SOR PGS LCP as implemented in quickstep.', 'max': 10000, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'sor_pgs_iters', 'edit_method': '', 'default': 20, 'level': 1, 'min': 0, 'type': 'int'}, {'srcline': 280, 'description': 'Relaxation parameter for SOR PGS LCP, usually set to 1.3, but reduce to stabilize simulation.', 'max': 5.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'sor_pgs_w', 'edit_method': '', 'default': 1.3, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'The number of scans to skip between each measured scan', 'max': 10000.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'sor_pgs_rms_error_tol', 'edit_method': '', 'default': -1.0, 'level': 1, 'min': -1.0, 'type': 'double'}, {'srcline': 280, 'description': "Constraint Force Mixing per ODE's users manual.", 'max': 10.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'cfm', 'edit_method': '', 'default': 0.0, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': "Error Reduction Parameter per ODE's users manual.", 'max': 10.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'erp', 'edit_method': '', 'default': 0.2, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'Margin for penetration for which restorative forces are not applied.', 'max': 10.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'contact_surface_layer', 'edit_method': '', 'default': 0.001, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'Maximum contact penetration correction velocity.', 'max': 10000000.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'contact_max_correcting_vel', 'edit_method': '', 'default': 100.0, 'level': 1, 'min': 0.0, 'type': 'double'}, {'srcline': 280, 'description': 'Maximum number of contacts between any 2 bodies.', 'max': 10000000, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '/home/fengkaiwen/caros/ros/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'max_contacts', 'edit_method': '', 'default': 100, 'level': 1, 'min': 0, 'type': 'int'}], 'type': '', 'id': 0}

min = {}
max = {}
defaults = {}
level = {}
type = {}
all_level = 0

#def extract_params(config):
#    params = []
#    params.extend(config['parameters'])    
#    for group in config['groups']:
#        params.extend(extract_params(group))
#    return params

for param in extract_params(config_description):
    min[param['name']] = param['min']
    max[param['name']] = param['max']
    defaults[param['name']] = param['default']
    level[param['name']] = param['level']
    type[param['name']] = param['type']
    all_level = all_level | param['level']

