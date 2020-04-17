var type = async_load[? "type"];

if(type == network_type_connect)
{
	var socket = async_load[? "socket"];
	
	var buffer = buffer_create(2, buffer_fixed, 1);
	
	buffer_write(buffer, buffer_u8, DATA.init_data);
	buffer_write(buffer, buffer_u8, ds_list_size(clients));
	
	network_send_packet(socket, buffer, buffer_get_size(buffer));
	buffer_delete(buffer);
	
	//create player
	var plr = instance_create_layer(100, 100, "InstanceLayer", obj_player);
	plr.player_id = ds_list_size(clients);
	plr.is_local = false;
	
	var buffer = buffer_create(2, buffer_fixed, 1);
	
	buffer_write(buffer, buffer_u8, DATA.player_join);
	buffer_write(buffer, buffer_u8, plr.player_id);
	
	for(var i=1; i<ds_list_size(clients); i++)
	{
		network_send_packet(ds_list_find_value(clients, i), buffer, buffer_get_size(buffer));
	}
	buffer_delete(buffer);
	
	//add to clients
	ds_list_add(clients, socket);
}

//Data
else if(type == network_type_data) {
	var buffer = async_load[? "buffer"];
	
	buffer_seek(buffer, buffer_seek_start, 0);
	var data = buffer_read(buffer, buffer_u8);
	
	switch(data)
	{
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
					x				= buffer_read(buffer, buffer_s16);
					y				= buffer_read(buffer, buffer_s16);
					image_xscale	= buffer_read(buffer, buffer_s8);
					sprite_index	= buffer_read(buffer, buffer_s16);
					image_index		= buffer_read(buffer, buffer_u8);
					var is_shooting	= buffer_read(buffer, buffer_u8); 
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
					show_debug_message(string(socket_id) + " equals " + string(i) + " for client " + string(socket_id));
					if(socket_id == i)
						continue;
					network_send_packet(ds_list_find_value(clients, i), buffer, buffer_get_size(buffer));
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
		#region enemy_update
		case DATA.enemy_update:
			obj_debug_gui.custom = string(buffer_get_size(buffer))
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
				
				ds_map_add(tracked_enemys, enemy_server_id, enemy_hp);
				
				//get instance with id
				with obj_slime_dev
				{
					if(enemy_id == enemy_server_id)
					{
						found_enemy		= true;
						x				= enemy_x;
						y				= enemy_y;
						sprite_index	= enemy_sprite_index;
						image_index		= enemy_image_index;
						max_hp			= enemy_max_hp;
						hp				= enemy_hp;
					}
				}
				//enemy has to be created
				if(!found_enemy)
				{
					new_enemy = instance_create_layer(enemy_x, enemy_y, "InstanceLayer", obj_slime_dev);
					new_enemy.enemy_id = enemy_server_id;
				}
			}
			break;
		#endregion
	}
}