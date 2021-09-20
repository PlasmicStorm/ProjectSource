#region debug interface
	if(room == r_init)
	{
		if(keyboard_check_pressed(vk_space)) 
		{
			//server = network_create_server(network_socket_udp, server_port, 6);
			server = network_create_socket_ext(network_socket_udp, server_port);

			//Fails
			if(server < 0)
				show_error("Could not create server.", false);
			else
			{
				room_goto(r_test);
			
				is_server = true;
			}
		}
		else if(keyboard_check_pressed(vk_enter))
		{
			server = network_create_socket(network_socket_udp);
			//var res = network_connect(server, server_ip, server_port);
		
			//Fails
			//if(res < 0)
				//show_error("Could not connect to server", false);
			//else
			var buffer = buffer_create(2, buffer_fixed, 1);
			buffer_write(buffer, buffer_u8, DATA.heartbeat);
			buffer_write(buffer, buffer_u8, ds_list_size(clients));
			network_send_udp(server, server_ip, server_port, buffer, buffer_get_size(buffer));
			room_goto(r_level_forest);
			connected = true;
		}
	}
#endregion
if(!is_server && connected)
{
	var buffer = buffer_create(2, buffer_fixed, 1);
	buffer_write(buffer, buffer_u8, DATA.heartbeat);
	buffer_write(buffer, buffer_u8, ds_list_size(clients));
	network_send_udp(server, server_ip, server_port, buffer, buffer_get_size(buffer));
	if(instance_exists(obj_debug_gui))
		 /*obj_debug_gui.custom = string(	"heartbeat " + 
										string(packetno) + 
										" dest " + 
										string(server_ip) + 
										":" + 
										string(server_port) + 
										"\nFrom client " +
										string(server));
										*/
	packetno++;
	exit;
}
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
	for(var i=0; i<ds_list_size(clients); i++)
	{
	//get client socket
	var soc = clients[| i];

	//Skip server player
	if(soc<0)
		continue;

	//Send
	//buffer_seek(buffer, buffer_seek_start, 0);
	network_send_udp(	ds_list_find_value(clients, i), 
									ds_grid_get(client_ips, 0, i),
									ds_grid_get(client_ips, 1, i),
									buffer,
									buffer_get_size(buffer));
	}
#endregion