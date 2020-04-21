///@param buffer

var buffer = argument0;

with obj_controller
{
	for(var i=0; i<ds_list_size(clients); i++)
	{
		//get client socket
		var soc = clients[| i];
		
		//Skip server player
		if(soc<0)
			continue;
			
		//Send
		network_send_udp(	soc, 
							ds_grid_get(client_ips, 0, i),
							ds_grid_get(client_ips, 1, i),
							buffer, 
							buffer_get_size(buffer));
	}
		
}