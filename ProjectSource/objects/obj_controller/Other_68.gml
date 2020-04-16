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
		show_debug_message(string(plr.player_id) + " to " +  string(ds_list_find_value(clients, i)));
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
			var pID = buffer_read(buffer, buffer_u8);
			
			with(obj_player)
			{
				if(pID == player_id)
				{
					x				= buffer_read(buffer, buffer_s16);
					y				= buffer_read(buffer, buffer_s16);
					image_xscale	= buffer_read(buffer, buffer_s8);
					sprite_index	= buffer_read(buffer, buffer_s16);
					image_index		= buffer_read(buffer, buffer_u8);
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
		#endregion
	}
}