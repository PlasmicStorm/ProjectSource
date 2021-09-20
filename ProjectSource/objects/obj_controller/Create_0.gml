//scr_open_two_windows();

randomize();

server_ip = "127.0.0.1";
server_port = 4269;

is_server = false;

enum DATA {
	init_data,
	player_update,
	player_join,
	player_damage,
	enemy_update,
	item_update,
	item_delete,
	spawn_portal,
	spawn_particle,
	spawn_projectile,
	heartbeat,
	nice_cock_bro
}

enum enemy_type
{
	slime
}

connected		= false;
packetno		= 0;
clients			= ds_list_create();
client_ips		= ds_grid_create(2, 0);
tracked_enemys	= ds_map_create();
tracked_items	= ds_map_create();