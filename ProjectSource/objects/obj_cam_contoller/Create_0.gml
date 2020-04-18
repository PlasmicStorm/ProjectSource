cam = camera_create();

if(instance_exists(obj_player))
{
	x = obj_player.x;
	y = obj_player.y;
}

pixel_res_x = 640;
pixel_res_y = 360;

var vm = matrix_build_lookat(x,y-10,x,y,0,0,0,1, 0);
var pm = matrix_build_projection_ortho(pixel_res_x, pixel_res_y, 1, 100000);
view_w = 640;
view_h = 360;

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);
camera_set_view_size(cam, pixel_res_x, pixel_res_y);

view_camera[0] = cam;

display_set_gui_size(view_w, view_h);
surface_resize(application_surface, view_w, view_h);
window_set_size(view_w, view_h);

target_obj	= obj_player;
target_x	= x;
target_y	= y;
cam_speed	= 25;
