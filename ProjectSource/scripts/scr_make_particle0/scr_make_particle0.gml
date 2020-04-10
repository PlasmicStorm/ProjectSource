///make_particle0(x, y, amount)

var xx = argument0;
var yy = argument1;
var amount = argument2
var range = 5;

repeat(amount)
{
	part_particles_create(	obj_particle_system0.particle_system0, 
							xx + random_range(-1 * range, range), 
							yy + random(range), 
							obj_particle_system0.particle0, 1);
}