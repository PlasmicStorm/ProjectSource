///@param damage

var damage = argument0;

show_debug_message("damage should be calculated. Cooldown: " + string(damage_cooldown));
if(damage_cooldown == 0)
{
	hp -= damage;
	damage_cooldown = 60;
	//create blood particles
	part_particles_create(	obj_particle_system0.particle_system0, 
							x + random_range(-10, 10), 
							y + 8 + random_range(-2, 5), 
							obj_particle_system0.particle3, 20);
}