///@param buffer
///@param exclude
function scr_net_send_to_clients(argument0, argument1) {

	var buffer	= argument0;
	var exclude	= argument1;

	with obj_controller
	{
		for(var i=0; i<ds_list_size(clients); i++)
		{
			//get client socket
			var soc = clients[| i];
		
			//Skip server player
			if(soc < 0)
				continue;
			if(exclude == i)
				continue;
			
			//Send
			network_send_udp(	soc, 
								ds_grid_get(client_ips, 0, i),
								ds_grid_get(client_ips, 1, i),
								buffer, 
								buffer_get_size(buffer));
		}
		
	}


}
