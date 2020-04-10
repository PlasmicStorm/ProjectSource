/// @description Insert description here

if(hp < 1)
{
	part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle0, 20);
	instance_destroy();
}

path_speed = path_speed * 0.9;
slime_cooldown	-= sign(slime_cooldown);

if(slime_cooldown == 0)
{
	slime_cooldown = 100;
	mp_potential_path_object(target_path, obj_player.x, obj_player.y, obj_collision, 1, obj_collision);
	path_start(target_path, 1, path_action_stop, false);
	path_speed = 5;
}
