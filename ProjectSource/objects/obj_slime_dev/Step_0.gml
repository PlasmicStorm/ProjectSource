/// @description Insert description here


//check if alive
if(hp < 1)
{
	part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle0, 20);
	instance_destroy();
}

//decrease move speed
//path_speed = path_speed * 0.9;
slime_cooldown	-= sign(slime_cooldown);

//Pathfinding
if(slime_cooldown <= 0 && instance_exists(obj_player))
{
	x_speed += sign(obj_player.x - x) + random_range(-1, 1);
	y_speed += sign(obj_player.y - y) + random_range(-1, 1);
	slime_cooldown -= 2;
	if(slime_cooldown <= -5)
	{
		slime_cooldown = floor(random_range(100, 150));
	}
}

if(place_free(x + x_speed, y))
	x += x_speed;
else
	x_speed *= -0.8;
if(place_free(x, y + y_speed))
	y += y_speed;
else
	y_speed *= -0.8;
	
x_speed *= 0.95;
y_speed *= 0.95;

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