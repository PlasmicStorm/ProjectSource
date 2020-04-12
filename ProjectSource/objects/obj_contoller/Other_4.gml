/// @description Insert description here

var cam = view_get_camera(0);
var view_w = 1920;
var view_h = 1080;
camera_set_view_size(cam, 384, 216);
display_set_gui_size(view_w, view_h);
surface_resize(application_surface, view_w, view_h);
window_set_size(view_w, view_h);