scr_open_two_windows();

randomize();

server_ip = "127.0.0.1";
server_port = 64046;

is_server = false;

enum DATA {
	init_data,
	player_update,
	player_join,
	nice_cock_bro
}

clients = ds_list_create();