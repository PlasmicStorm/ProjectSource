port = 64046;
max_clients = 4;

network_create_server(network_socket_tcp, port, max_clients);

server_buffer	= buffer_create(1024, buffer_fixed, 1);
socket_list		= ds_list_create();