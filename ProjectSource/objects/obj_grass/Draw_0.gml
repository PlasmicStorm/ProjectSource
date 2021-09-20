var size = 4;

//Shader has to be drawn here to prevent shader glitches

scr_draw_shadow(0.3, 0, 0, 0.4, false);
shader_set(shd_distort);
	texture_set_stage(u_distort_tex, distort_tex);
	
	shader_set_uniform_f(u_time, time);
	shader_set_uniform_f(u_size, size);
	shader_set_uniform_f(u_strength, strength);
	shader_set_uniform_f_array(u_tex_offset, tex_offset);
	draw_sprite(sprite_index, image_index, x, y);
shader_reset();