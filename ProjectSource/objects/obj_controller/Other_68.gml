var buffer = async_load[? "buffer"];
	
	buffer_seek(buffer, buffer_seek_start, 0);
	var data = buffer_read(buffer, buffer_u8);
	
switch(data)
{
	#region heartbeat
		case DATA.heartbeat:
		var socket		= async_load[? "id"];
		var socket_ip	= async_load[? "ip"];
		var socket_port = async_load[? "port"];
		//show_debug_message("Received heartbeat from: " + string(socket) + " ip: " + string(socket_ip) + ":" + string(socket_port) + " known instances: " +  string(ds_list_size(clients)));
		if(	!ds_grid_value_exists(client_ips, 0, 0, 0, ds_grid_height(client_ips), socket_ip) ||
			!ds_grid_value_exists(client_ips, 1, 0, 1, ds_grid_height(client_ips), socket_port)) //ds_list_find_index(clients, socket) == -1)
		{
			var buffer = buffer_create(2, buffer_fixed, 1);
	
			buffer_write(buffer, buffer_u8, DATA.init_data);
			buffer_write(buffer, buffer_u8, ds_list_size(clients));
	
			network_send_udp(socket, socket_ip, socket_port, buffer, buffer_get_size(buffer));
			buffer_delete(buffer);
	
			//create player
			var plr = instance_create_layer(100, 100, "InstanceLayer", obj_player);
			plr.player_id = ds_list_size(clients);
			plr.is_local = false;
	
			var buffer = buffer_create(2, buffer_fixed, 1);
	
			buffer_write(buffer, buffer_u8, DATA.player_join);
			buffer_write(buffer, buffer_u8, plr.player_id);
	
			scr_net_send_to_clients(buffer, -1);
	
			//add to clients
			ds_list_add(clients, socket);
			ds_grid_resize(client_ips, 2, ds_list_size(clients));
			ds_grid_set(client_ips,0, ds_list_size(clients) - 1, socket_ip);
			ds_grid_set(client_ips,1, ds_list_size(clients) - 1, socket_port);
			show_debug_message("New Client added to known clients: " + string(socket_ip) + ":" + string(socket_port))
		}
		break;
	#endregion
	
	#region init_data
	case DATA.init_data:
		var count = buffer_read(buffer, buffer_u8);
		
		//set your player's ID
		obj_player.player_id = count;
		
		//Create other Players
		for (var i=0; i < count; i++)
		{
			var plr = instance_create_layer(random(100), 150, "InstanceLayer", obj_player);
			plr.player_id = i;
			plr.is_local = false;
		}
		break;
	#endregion
	
	#region player_update
	case DATA.player_update:
		var pID				= buffer_read(buffer, buffer_u8);
		if(obj_player.player_id == pID) break;
		with(obj_player)
		{
			if(pID == player_id)
			{
				hp				= buffer_read(buffer, buffer_u16);
				invincible		= buffer_read(buffer, buffer_bool);
				x				= buffer_read(buffer, buffer_s16);
				y				= buffer_read(buffer, buffer_s16);
				image_xscale	= buffer_read(buffer, buffer_s8);
				sprite_index	= buffer_read(buffer, buffer_s16);
				image_index		= buffer_read(buffer, buffer_u8);
				damage_cooldown	= buffer_read(buffer, buffer_u8);
				var is_shooting	= buffer_read(buffer, buffer_u8);
				alive			= (hp > 0);
				if(is_shooting)
				{
					var shot_projectile			= instance_create_layer(x, y, "InstanceLayer", obj_projectile);
					shot_projectile.damage		= buffer_read(buffer, buffer_u16);
					shot_projectile.direction	= buffer_read(buffer, buffer_s16);
				}
			}
		}
		if(is_server)
		{
			var socket_id = buffer_read(buffer, buffer_u8);
			buffer_seek(buffer, buffer_seek_start, 0);
			for(var i = 1; i<ds_list_size(clients); i++)
			{
				if(socket_id == i)
					continue;
				network_send_udp(	ds_list_find_value(clients, i), 
									ds_grid_get(client_ips, 0, i),
									ds_grid_get(client_ips, 1, i),
									buffer,
									buffer_get_size(buffer));
			}
		}
		break;
	#endregion
	
	#region player_join
	case DATA.player_join:
		var new_player_id = buffer_read(buffer, buffer_u8);

		//Create other Players
		var plr = instance_create_layer(random(100), 150, "InstanceLayer", obj_player);
		plr.player_id = new_player_id;
		plr.is_local = false;
		break;
	#endregion
	
	#region player_damage
	case DATA.player_damage:
		var damage					= buffer_read(buffer, buffer_u16);
		var player_dmg_id			= buffer_read(buffer, buffer_u8);
		with obj_player
		{
			if(player_id = player_dmg_id)
			{
				show_debug_message("Yeet");
				//damage_cooldown = 60;
				scr_take_damage(damage, player_dmg_id);
			}
		}
		break;
	#endregion
	
	#region enemy_update
	case DATA.enemy_update:
		var enemy_count = buffer_read(buffer, buffer_u16);
		ds_map_clear(tracked_enemys);
			
		for(var i = 0; i<enemy_count; i++)
		{
			var found_enemy = false;
			var enemy_server_id		= buffer_read(buffer, buffer_u16);
			var enemy_x				= buffer_read(buffer, buffer_s16);
			var enemy_y				= buffer_read(buffer, buffer_s16);
			var enemy_sprite_index	= buffer_read(buffer, buffer_s16);
			var enemy_image_index	= buffer_read(buffer, buffer_u8);
			var enemy_max_hp		= buffer_read(buffer, buffer_u8);
			var enemy_hp			= buffer_read(buffer, buffer_u8);
			var enemy_type_server	= buffer_read(buffer, buffer_u8);
				
			ds_map_add(tracked_enemys, enemy_server_id, enemy_hp);
				
			//get instance with id
			with obj_enemy
			{
				if(enemy_id == enemy_server_id)
				{
					found_enemy		= true;
					x				= real(enemy_x);
					y				= real(enemy_y);
					sprite_index	= enemy_sprite_index;
					image_index		= enemy_image_index;
					max_hp			= enemy_max_hp;
					hp				= enemy_hp;
				}
			}
			
			//enemy has to be created
			if(!found_enemy)
			{
				new_enemy = instance_create_layer(enemy_x, enemy_y, "InstanceLayer", scr_get_obj_from_enemy_type(enemy_type_server));
				new_enemy.enemy_id = enemy_server_id;
			}
		}
		if(instance_exists(obj_debug_gui))
				ds_map_copy(obj_debug_gui.custom, tracked_enemys);
		break;
	#endregion
	
	#region item_update
	case DATA.item_update:
		var item_count = buffer_read(buffer, buffer_u16);
		ds_map_clear(tracked_items);

		for(var i = 0; i<item_count; i++)
		{
			var found_item = false;
			var item_server_id			= buffer_read(buffer, buffer_u16);
			var item_server_id_unique	= buffer_read(buffer, buffer_u32);
			var item_x					= buffer_read(buffer, buffer_s16);
			var item_y					= buffer_read(buffer, buffer_s16);
				
			ds_map_add(tracked_items, item_server_id_unique, item_server_id);
				
				
			//get instance with id
			with obj_item
			{
				if(unique_item_id == item_server_id_unique)
				{
					found_item		= true;
					x				= item_x;
					y				= item_y;
					item_id			= item_server_id;
				}
			}
			//item has to be created
			if(!found_item)
			{
				var new_item			= instance_create_layer(item_x, item_y, "InstanceLayer", obj_item);
				new_item.item_id		= item_server_id;
				new_item.unique_item_id	= item_server_id_unique;
			}
		}
		break;
	#endregion	
	
	#region item_delete
	case DATA.item_delete:
		var item_unique_client_id	= buffer_read(buffer, buffer_u16);
			
		with obj_item
		{
			if(unique_item_id == item_unique_client_id)
			{
				part_particles_create(	obj_particle_system0.particle_system0, 
						x, 
						y, 
						obj_particle_system0.particle4, 40);
						instance_destroy();
			}
		}
			
		break;
	#endregion
	
	#region spawn_portal
	case DATA.spawn_portal:
		var xx	= buffer_read(buffer, buffer_s16);
		var yy	= buffer_read(buffer, buffer_s16);
		instance_create_layer(xx, yy, "InstanceLayer", obj_portal);
		break;
	#endregion
	
	#region spawn_particle
	case DATA.spawn_particle:
	
	break;
	#endregion
	
	#region spawn_projectile
	case DATA.spawn_projectile:
		var xx				= buffer_read(buffer, buffer_s16);
		var yy				= buffer_read(buffer, buffer_s16);
		var dmg				= buffer_read(buffer, buffer_u16);
		var client_id		= buffer_read(buffer, buffer_u8);
		var new_instance	= instance_create_layer(xx, yy, "InstanceLayer", obj_blink_damage);
		new_instance.damage = dmg;
		scr_net_send_to_clients(buffer, client_id);
	break;
	#endregion
}