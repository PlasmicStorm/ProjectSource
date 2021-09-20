///@param player_id
///@param damage_cooldown
///@param shoot
///@param shot_dmg
function scr_update_player(argument0, argument1, argument2, argument3) {

	var player_id		= argument0;
	var damage_cooldown = argument1;
	var shoot			= argument2;
	var shot_dmg		= argument3;

	//Create Buffer
	var buffer = buffer_create(20, buffer_fixed, 1);
	buffer_write(buffer, buffer_u8,		DATA.player_update);
	buffer_write(buffer, buffer_u8,		player_id);
	buffer_write(buffer, buffer_u16,	hp);
	buffer_write(buffer, buffer_bool,	invincible);
	buffer_write(buffer, buffer_s16,	x);
	buffer_write(buffer, buffer_s16,	y);
	buffer_write(buffer, buffer_s8,		image_xscale);
	buffer_write(buffer, buffer_s16,	sprite_index);
	buffer_write(buffer, buffer_u8,		image_index);
	buffer_write(buffer, buffer_u8,		damage_cooldown);
	buffer_write(buffer, buffer_u8,		shoot);
	buffer_write(buffer, buffer_u16,	shot_dmg);
	buffer_write(buffer, buffer_s16,	point_direction(x, y, mouse_x, mouse_y));

	//Send to server
	if(obj_controller.is_server)
	{
		scr_net_send_to_clients(buffer, -1);
	}
	else
	{
		scr_net_send_to_server(buffer);
	}

	//Delete buffer
	buffer_delete(buffer);


}
