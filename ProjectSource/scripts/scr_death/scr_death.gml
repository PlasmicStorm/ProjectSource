//create blood particles
part_particles_create(	obj_particle_system1.particle_system0, x, y-4, obj_particle_system1.particle1, 50);
repeat(40)
{
	part_particles_create(	obj_particle_system0.particle_system0, 
						x + random_range(-8, 8), 
						y + 8 + random(4), 
						obj_particle_system0.particle3, 1);
}