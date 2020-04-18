time	 += 0.002;
var size = 4;

//Shader has to be drawn here to prevent shader glitches
scr_draw_shadow(0.3, 0, -2, 0.3, false);

shader_set(shd_distort);
	texture_set_stage(u_distort_tex, distort_tex);
	
	shader_set_uniform_f(u_time, time);
	shader_set_uniform_f(u_size, size);
	shader_set_uniform_f(u_strength, strength);
	shader_set_uniform_f_array(u_tex_offset, tex_offset);
	
	draw_sprite(sprite_index, image_index, x, y);
shader_reset();

draw_text(x, y, string(obj_controller.is_server));
scr_draw_health(max_hp, hp, 10);