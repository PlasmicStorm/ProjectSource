/// @description Insert description here


//check if alive
if(hp < 1)
{
	part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle0, 20);
	instance_destroy();
}

//decrease move speed
path_speed = path_speed * 0.9;
slime_cooldown	-= sign(slime_cooldown);


//Pathfinding
if(slime_cooldown == 0)
{
	slime_cooldown = 100;
	if(instance_exists(obj_player))
		mp_potential_path_object(target_path, obj_player.x, obj_player.y, obj_collision, 1, obj_collision);
	path_start(target_path, 1, path_action_stop, false);
	path_speed = 5;
}

//Do damage
var colliding_instance = instance_place(x, y, obj_player);
if(colliding_instance != noone)
{
	with colliding_instance
		scr_take_damage(1);
}

if(frame_cooldown <= 0)
{
	frame_cooldown = sprite_index.image_speed;
	image_index = (image_index + 1) % sprite_get_number(sprite_index);
}