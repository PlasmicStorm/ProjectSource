///@param damage

var damage = argument0;

//show_debug_message("damage should be calculated. Cooldown: " + string(damage_cooldown) + " invincible? " + string(invincible));
if(damage_cooldown == 0 && !invincible)
{
	hp -= damage;
	damage_cooldown = 60;
	//create blood particles
	part_particles_create(	obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle1, 20);
	repeat(20)
	{
		part_particles_create(	obj_particle_system0.particle_system0, 
							x + random_range(-4, 4), 
							y + 8 + random(2), 
							obj_particle_system0.particle3, 1);
	}
}