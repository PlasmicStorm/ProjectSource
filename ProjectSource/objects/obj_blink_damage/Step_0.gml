if(!damage_done)
{
	var colliding_instance = collision_circle(x, y, 30, obj_enemy, false, false);
	if(colliding_instance != noone)
		colliding_instance.hp -= damage;
	damage_done = true;
}

if(image_index > 3)
{
	instance_destroy();
}