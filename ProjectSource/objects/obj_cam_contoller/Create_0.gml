cam = camera_create();

var vm = matrix_build_lookat(x,y-10,x,y,0,0,0,1, 0);
var pm = matrix_build_projection_ortho(320, 180, 1, 100000);
var view_w = 1920;
var view_h = 1080;

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);
camera_set_view_size(cam, 320, 180);

view_camera[0] = cam;

display_set_gui_size(view_w, view_h);
surface_resize(application_surface, view_w, view_h);
window_set_size(view_w, view_h);

target_obj	= obj_player;
target_x	= x;
target_y	= y;
cam_speed	= 25;