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