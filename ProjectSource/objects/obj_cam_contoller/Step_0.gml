x += (target_x - x + (mouse_x - x)/5)/cam_speed;
y += (target_y - y + (mouse_y - y)/5)/cam_speed;

if(instance_exists(obj_player))
{
	target_x = target_obj.x;
	target_y = target_obj.y;
}



var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
camera_set_view_mat(cam, vm);

view_camera[0].x = x;
view_camera[0].y = y;
show_debug_message(string(camera_get_view_x(view_camera[0])) + " " + string(view_camera[0].y));