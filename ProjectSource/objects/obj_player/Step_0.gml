//Check if player is alive
if(!alive)
{
	sprite_index = spr_player_death;
	scr_update_player(player_id, damage_cooldown, false, shot_dmg);
	exit;
}

//Check if player is local
if(!is_local) 
	exit;

//Check if player is in stasis
if(stasis)
	exit;

//Check Inputs
var move_dir_up		= keyboard_check(ord("W"));
var move_dir_down	= keyboard_check(ord("S"));
var move_dir_left	= keyboard_check(ord("A"));
var move_dir_right	= keyboard_check(ord("D"));
var move_dodge		= keyboard_check(vk_space) && dodge_cooldown = 0;
var shoot			= mouse_check_button(mb_left) && bullet_cooldown == 0;

//Set temp vars for input and speed
var y_dir = move_dir_down - move_dir_up;
var x_dir = move_dir_right - move_dir_left;
y_speed += y_dir*2;
x_speed += x_dir*2;

#region Health
	//Check if life bug triggers
	if(hp/max_hp <= 0.2 && life_bug_cooldown == 0 && scr_get_item_amount(2) != 0)
	{
		part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle3, 20);
		hp = min(scr_get_item_amount(2)/10 * max_hp, max_hp);
		life_bug_cooldown = 360 - scr_get_item_amount(2) * 10;
	}

	//Check if player is alive
	if(hp <= 0)
	{
		scr_death();
		alive	= false;
	}
#endregion

#region Movement
	//Do dodgeroll
	if(move_dodge)
	{
		if(0 == y_dir && 0 == x_dir)
			x_speed = 100 * image_xscale;
		else
			x_speed = 100 * x_dir;
		y_speed			= 100 * y_dir;
		dodge_startup	= 20;
		dodge_cooldown	= 120;
		dodge_animation = 20;
		dodge_status	= true;
	}
	if(dodge_startup > 0)
		dodge_startup--;

	if(dodge_startup > 0)
	{
		var final_x_speed = 0;
		var final_y_speed = 0;
	}
	else
	{
		var final_x_speed = x_speed * x_speed_multiply;
		var final_y_speed = y_speed * y_speed_multiply;
	}

	//Collision
	if(place_free(x + final_x_speed, y))
		x += final_x_speed;
	if(place_free(x, y + final_y_speed))
		y += final_y_speed;

	//reduce speed
	if(dodge_startup <= 0)
	{
		x_speed *= 0.8;
		y_speed *= 0.8;
	}
#endregion

#region Animation
	if(!dodge_status)
	{
		if(move_dir_right || move_dir_left)
			sprite_index = spr_player_walk;
		if(!(move_dir_down || move_dir_up || move_dir_left || move_dir_right))
			sprite_index = spr_player_idle;
	}

	//Set player sprite direction
	if(0 != sign(x_speed))
		image_xscale = sign(x_speed);

	//Animate blink
	if(move_dodge)
	{
		invincible = true;
		//set roll animation depending on dir
		if(abs(y_dir))
			sprite_index = spr_player_roll_front;
		else
			sprite_index = spr_player_blink_right;
	}
	else if(dodge_status)
	{
		if(image_index > 4 && dodge_animation > 0)
		{
			//show_debug_message(string(dodge_animation));
			image_index = 4;
			dodge_animation--;
		}
	}

	//Emit particles while in roll
	if(dodge_status)
	{
		scr_make_particle0_0(x, y + 5, 2);
	}
#endregion

#region Damage
	if(shoot) 
	{
		var fire_rate_buff		= scr_get_item_amount(0);
		shot_dmg				= base_damage;
		bullet_cooldown			= ceil(max(20 * exp(fire_rate_buff * -0.05), 0));
		var shot_projectile		= instance_create_layer(x, y, "InstanceLayer", obj_projectile);
		shot_projectile.damage	= shot_dmg;
	}
	
	if(dodge_status && image_index > 7 && !dodge_damage)
	{
		var colliding_instance = collision_circle(x, y, 30, obj_enemy, false, false);
		
		if(colliding_instance != noone)
		{
			dodge_damage = true;
			if(colliding_instance.hp <= base_damage)
			{
				instance_create_layer(x, y, "InstanceLayer", obj_blink_damage);
				dodge_cooldown	= 0;
				dodge_damage	= false;
				var buffer = buffer_create(8, buffer_fixed, 1);
				buffer_write(buffer, buffer_u8, DATA.spawn_projectile)
				buffer_write(buffer, buffer_s16, x);
				buffer_write(buffer, buffer_s16, y);
				buffer_write(buffer, buffer_u16, base_damage);
				buffer_write(buffer, buffer_u8, player_id);
				
				if(obj_controller.is_server)
					scr_net_send_to_clients(buffer, -1);
				else
					scr_net_send_to_server(buffer);
			}
		}
	}
#endregion

#region Item collection
	//Check for item
	var colliding_instance = instance_place (x, y, obj_item);
	if(colliding_instance != noone && -1 == ds_list_find_index(collected_items, colliding_instance.unique_item_id))
	{
		scr_add_item(colliding_instance.item_id);
		part_particles_create(	obj_particle_system0.particle_system0, 
								colliding_instance.x, 
								colliding_instance.y, 
								obj_particle_system0.particle4, 40);
		//Update stats
		base_damage = 1 + scr_get_item_amount(1);
	
		//Send data to Server
		if(!obj_controller.is_server)
		{
			var buffer = buffer_create(4, buffer_fixed, 1);
		
			buffer_write(buffer, buffer_u8,		DATA.item_delete);
			buffer_write(buffer, buffer_u16,	colliding_instance.unique_item_id);
			buffer_write(buffer, buffer_u8,		player_id);
		
			with obj_controller
				network_send_udp(server, server_ip, server_port, buffer, buffer_get_size(buffer));
		}
		ds_list_add(collected_items, colliding_instance.unique_item_id);
	
		//Delete instance
		instance_destroy(colliding_instance);
	}
#endregion

#region Cleanup
	//Reduce cooldowns
	dodge_cooldown		-= sign(dodge_cooldown);
	bullet_cooldown		-= sign(bullet_cooldown);
	damage_cooldown		-= sign(damage_cooldown);
	life_bug_cooldown	-= sign(life_bug_cooldown);
#endregion

#region Networking
	scr_update_player(player_id, damage_cooldown, shoot, shot_dmg);
#endregion