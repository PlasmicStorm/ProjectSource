//Create surface to draw lights
if(!surface_exists(srf_lights))
{
	srf_lights = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
	tex_lights = surface_get_texture(srf_lights);
}

//Draw blank light surface
surface_set_target(srf_lights);
	
	//set up surface and gpu
	draw_clear(c_black);
	gpu_set_blendmode(bm_add);
	gpu_set_tex_filter(true);
	
	var lights_strength = 1.0;
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	//draw all light instances 
	with(par_lights)
		draw_sprite_ext(sprite_index, image_index, x - vx, y - vy, image_xscale, image_yscale, image_angle, image_blend, image_alpha * lights_strength);
	
	//reset gpu
	gpu_set_tex_filter(false);
	gpu_set_blendmode(bm_normal);
surface_reset_target();


//Draw with shader enabled
shader_set(shd_colour);
	shader_set_uniform_f_array(u_col, colour_mix);
	shader_set_uniform_f_array(u_con_sat_brt, con_sat_brt_mix);
	texture_set_stage(s_lights, tex_lights);
	if(surface_exists(application_surface))
		draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
shader_reset();

//debug lighting surface
	draw_surface_ext(srf_lights,0 ,0 ,1, 1, 0, c_white, 1);