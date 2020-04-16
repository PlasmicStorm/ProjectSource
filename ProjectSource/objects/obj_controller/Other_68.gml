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
		case DATA.init_data:
			var count = buffer_read(buffer, buffer_u8);
		
			//set your player's ID
			obj_player.player_id = count;
		
			//Crate other Players
			for (var i=0; i < count; i++)
			{
				var plr = instance_create_layer(150, 150, "InstanceLayer", obj_player);
				plr.player_id = i;
				plr.is_local = false;
			}
			break;
			
		case DATA.player_update:
			var pID = buffer_read(buffer, buffer_u8);
		
			with(obj_player)
			{
				if(pID == player_id)
				{
					x = buffer_read(buffer, buffer_s16);
					y = buffer_read(buffer, buffer_s16);
				}
			}
			break;
	}
}