time += 0.002;
var size = 4;

scr_draw_shadow(0.3, 0, -2, 0.3, false);
scr_draw_health(max_hp, hp, 10);
//draw_text(x, y, string(enemy_id));
draw_sprite(sprite_index, image_index, x, y);
/* Disabled due to drawing issues with alpha values on grass patches
shader_set(shd_distort);
	texture_set_stage(u_distort_tex, distort_tex);
	
	shader_set_uniform_f(u_time, time);
	shader_set_uniform_f(u_size, size);
	shader_set_uniform_f(u_strength, strength);
	shader_set_uniform_f_array(u_tex_offset, tex_offset);
	
	draw_sprite(sprite_index, image_index, x, y);
shader_reset();
*/