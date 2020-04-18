sprite_index = scr_get_item_sprite(item_id);
scr_draw_shadow(0.5, 0, sin(y_height * -0.05), 0.3, true);
draw_sprite_ext(sprite_index, image_index, x, y + 2 * sin(y_height * 0.05) - 2, 1, 1, 0, c_white, 1);

if(floor(random(10)) == 0)
{
	part_particles_create(	obj_particle_system0.particle_system0, 
							x, 
							y, 
							obj_particle_system0.particle5, 1);
}