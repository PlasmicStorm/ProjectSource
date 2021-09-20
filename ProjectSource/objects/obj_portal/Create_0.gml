summon_time	= 30;
if(obj_controller.is_server)
{
	var buffer = buffer_create(5, buffer_fixed, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, DATA.spawn_portal);
	buffer_write(buffer, buffer_s16, x);
	buffer_write(buffer, buffer_s16, y);
	
	scr_net_send_to_clients(buffer, -1);
}