#region debug interface
	if(room == r_init)
	{
		if(keyboard_check_pressed(vk_space)) 
		{
			server = network_create_server(network_socket_tcp, server_port, 6);
		
			//Fails
			if(server < 0)
				show_error("Could not create server.", false);
			else
			{
				room_goto(r_castle);
			
				is_server = true;
			}
		}
		else if(keyboard_check_pressed(vk_enter))
		{
			server = network_create_socket(network_socket_tcp);
			var res = network_connect(server, server_ip, server_port);
		
			//Fails
			if(res < 0)
				show_error("Could not connect to server", false);
			else
				room_goto(r_castle);
		}
	}
#endregion
if(!is_server) exit;
#region synchronize items
	var buffer = buffer_create(instance_number(obj_item) * 10 + 3, buffer_fixed, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, DATA.item_update);
	buffer_write(buffer, buffer_u16, instance_number(obj_item));
	with obj_item
	{
		buffer_write(buffer, buffer_u16, item_id);
		buffer_write(buffer, buffer_u32, unique_item_id);
		buffer_write(buffer, buffer_s16, x);
		buffer_write(buffer, buffer_s16, y);
	}
	for(var i=0; i<ds_list_size(obj_controller.clients); i++)
	{
	//get client socket
	var soc = obj_controller.clients[| i];

	//Skip server player
	if(soc<0)
		continue;

	//Send
	//buffer_seek(buffer, buffer_seek_start, 0);
	network_send_packet(soc, buffer, buffer_get_size(buffer));
	}
#endregion