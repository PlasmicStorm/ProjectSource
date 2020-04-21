///@param buffer

var buffer = argument0;

with obj_controller
		network_send_udp(server, server_ip, server_port, buffer, buffer_get_size(buffer));