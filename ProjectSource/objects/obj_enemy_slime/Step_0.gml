depth = room_height-y;

#region Health
	//Check if player is local
	if(!obj_controller.is_server) 
	{
		if(!ds_map_exists(obj_controller.tracked_enemys, enemy_id))
		{
			part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle0, 20);
			instance_destroy();
		}
		exit;
	}

	//check if alive
	if(hp < 1)
	{
		part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle0, 20);
		var temp			= instance_create_layer(x, y, "InstanceLayer", obj_item);
		temp.item_id		= round(random(2));
		temp.unique_item_id	= round(random(65535));
		instance_destroy();
	}
#endregion

#region Movement

	if(collision_circle(x, y, target_range, target_player, false, true) == noone || target_player == noone)
	{
		//Get players in range
		var target_list	= ds_list_create();
		collision_circle_list(x, y, target_range, obj_player, false, true, target_list, false);
		
		//Set target to a live player
		for(var i = 0; i < ds_list_size(target_list); i++)
		{
			var target_player_temp = ds_list_find_value(target_list, i);
			if(target_player_temp.alive)
			{
				target_player = target_player_temp;
				break;
			}
		}
	}
	//Check if target is outside of range
	else if(noone == collision_circle(x, y, target_range, obj_player, false, true))
		target_player = noone;
	
	if(target_player == noone ? false : !target_player.alive)
		target_player = noone

	slime_cooldown -= sign(slime_cooldown);
	if(slime_cooldown <= 0)
	{
		//Idle movement
		if(target_player == noone)
		{
			x_speed += cos(target_direction);
			y_speed += sin(target_direction);
		}
		//Dash into player direction
		else
		{
			x_speed += sign(target_player.x - x) + random_range(-1, 1);
			y_speed += sign(target_player.y - y) + random_range(-1, 1);
		}
		slime_cooldown -= 2;
		//Initiate dash
		if(slime_cooldown <= -5)
		{
			target_direction = random(360);
			slime_cooldown = floor(random_range(100, 150));
		}
	}

	//Collision
	if(place_free(x + x_speed, y) && !place_meeting(x + x_speed, y, obj_enemy))
		x += x_speed;
	else {
		var hit = instance_place(x + x_speed, y, obj_enemy)
		if(hit != noone) {
			hit.x_speed = hit.knockback_factor * x_speed;
		}
		x_speed *= -0.8;
	}
	if(place_free(x, y + y_speed) && !place_meeting(x, y + y_speed, obj_enemy))
		y += y_speed;
	else {
		var hit = instance_place(x, y + y_speed, obj_enemy)
		if(hit != noone) {
			hit.y_speed = hit.knockback_factor * y_speed;
		}
		y_speed *= -0.8;
	}
	
	x_speed *= 0.95;
	y_speed *= 0.95;
#endregion

#region do Damage
	var colliding_instance = instance_place(x, y, obj_player);
	if(colliding_instance != noone)
	{
		with colliding_instance
			scr_take_damage(1, colliding_instance.player_id);
	}
#endregion