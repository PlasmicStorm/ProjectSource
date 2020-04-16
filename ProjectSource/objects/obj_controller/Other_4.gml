if(room == r_castle)
{
	var plr = instance_create_layer(100, 100, "InstanceLayer", obj_player)
	plr.player_id = 0;
	
	if(is_server) 
		ds_list_add(clients, -1);
}