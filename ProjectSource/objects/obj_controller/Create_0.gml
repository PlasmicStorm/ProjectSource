scr_open_two_windows();

randomize();

server_ip = "79.249.151.89";
server_port = 64046;

is_server = false;

enum DATA {
	init_data,
	player_update,
	player_join,
	enemy_update,
	item_update,
	item_delete,
	nice_cock_bro
}

clients = ds_list_create();
tracked_enemys	= ds_map_create();
tracked_items	= ds_map_create();