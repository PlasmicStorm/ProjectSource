/// @description Insert description here
// You can write your code in this editor

time				+= 0.002;
var size			= 4;

//Shader has to be drawn here to prevent shader glitches
draw_sprite_ext(sprite_index, image_index, x, y + sprite_height - 8, image_xscale, image_yscale * -0.3, 0, c_black, 0.3);

shader_set(shd_distort);
	texture_set_stage(u_distort_tex, distort_tex);
	
	shader_set_uniform_f(u_time, time);
	shader_set_uniform_f(u_size, size);
	shader_set_uniform_f(u_strength, strength);
	shader_set_uniform_f_array(u_tex_offset, tex_offset);
	
	draw_sprite(sprite_index, image_index, x, y);
shader_reset();
