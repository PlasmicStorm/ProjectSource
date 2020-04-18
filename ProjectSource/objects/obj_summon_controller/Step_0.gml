if(!obj_controller.is_server) exit;

if(spawn_timer == 0)
{
	x = random(room_width);
	y = random(room_height);
	while(!place_empty(x,y, obj_collision))
	{
		x = random(room_width);
		y = random(room_height);
	}
	
	var summon_creature = instance_create_layer(x, y, "InstanceLayer", obj_portal);
	summon_creature.summoned_instance = obj_enemy;
	
	spawn_timer = spawn_cooldown;
}
spawn_timer -= sign(spawn_timer);

//Networking
var buffer = buffer_create(instance_number(obj_enemy) * 11 + 3, buffer_fixed, 1);
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, DATA.enemy_update);
buffer_write(buffer, buffer_u16, instance_number(obj_enemy));
with obj_enemy
{
	buffer_write(buffer, buffer_u16, enemy_id);
	buffer_write(buffer, buffer_s16, x);
	buffer_write(buffer, buffer_s16, y);
	buffer_write(buffer, buffer_s16, sprite_index);
	buffer_write(buffer, buffer_u8, image_index);
	buffer_write(buffer, buffer_u8, max_hp);
	buffer_write(buffer, buffer_u8, hp);
}
for(var i=0; i<ds_list_size(obj_controller.clients); i++)
{
	//get client socket
	var soc = obj_controller.clients[| i];
		
	//Skip server player
	if(soc<0)
		continue;
			
	//Send
	buffer_seek(buffer, buffer_seek_start, 0);
	network_send_packet(soc, buffer, buffer_get_size(buffer));
	//show_debug_message("Client: " + string(soc) + " buffsize " + string(buffer_get_size(buffer)));
}
