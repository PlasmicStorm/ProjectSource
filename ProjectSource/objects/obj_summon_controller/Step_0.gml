if(!obj_controller.is_server) exit;

if(spawn_timer == 0)
{
	x = random(room_width);
	y = random(room_height);
	while(!place_empty(x,y, obj_collision))
	{
		x = random(room_width);
		y = random(room_height);
	}
	var summon_creature = instance_create_layer(x, y, "InstanceLayer", obj_portal);
	summon_creature.summoned_instance = obj_slime_dev;
	spawn_timer = spawn_cooldown;
}
spawn_timer -= sign(spawn_timer);