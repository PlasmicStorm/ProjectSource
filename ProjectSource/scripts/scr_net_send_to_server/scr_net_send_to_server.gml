///@param buffer
function scr_net_send_to_server(argument0) {

	var buffer = argument0;

	with obj_controller
			network_send_udp(server, server_ip, server_port, buffer, buffer_get_size(buffer));


}
