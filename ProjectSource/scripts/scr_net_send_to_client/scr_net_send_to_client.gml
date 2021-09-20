///@param buffer
///@param client
function scr_net_send_to_client(argument0, argument1) {

	var buffer = argument0;
	var client = argument1;

	with obj_controller
	{
		if(client >= ds_list_size(clients))
			exit;
		//get client socket
		var soc = clients[| client];
		
		//Send
		network_send_udp(	soc,
							ds_grid_get(client_ips, 0, client),
							ds_grid_get(client_ips, 1, client),
							buffer,
							buffer_get_size(buffer));
	}


}
