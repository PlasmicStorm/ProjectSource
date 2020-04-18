/// @description Movement + Animation

//Check if player is local
if(!is_local) 
	exit;

//Check if player is in stasis
if(stasis)
	exit;

//Check Inputs
var move_dir_up		= keyboard_check(ord("W"));
var move_dir_down	= keyboard_check(ord("S"));
var move_dir_left	= keyboard_check(ord("A"));
var move_dir_right	= keyboard_check(ord("D"));
var move_dodge		= keyboard_check(vk_space) && dodge_cooldown = 0;
var shoot			= mouse_check_button(mb_left) && bullet_cooldown == 0;

//Set temp vars for input and speed
var y_dir = move_dir_down - move_dir_up;
var x_dir = move_dir_right - move_dir_left;
y_speed += y_dir;
x_speed += x_dir;

//Check if life bug triggers
if(hp/max_hp <= 0.2 && life_bug_cooldown == 0 && scr_get_item_amount(2) != 0)
{
	part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle3, 20);
	hp = min(scr_get_item_amount(2)/10 * max_hp, max_hp);
	life_bug_cooldown = 360 - scr_get_item_amount(2) * 10;
}

//Check if player is alive
if(hp <= 0)
{
	scr_death();
	instance_destroy();
}


//Do dodgeroll
if(move_dodge)
{
	if(0 == y_dir && 0 == x_dir)
		x_speed = 50 * image_xscale;
	else
		x_speed = 50 * x_dir;
	y_speed = 50 * y_dir;
	dodge_cooldown = 60;
}

var final_x_speed = x_speed * x_speed_multiply;
var final_y_speed = y_speed * y_speed_multiply;

//Collision
if(place_free(x + final_x_speed, y))
	x += final_x_speed;
if(place_free(x, y + final_y_speed))
	y += final_y_speed;

//reduce speed
x_speed *= 0.8;
y_speed *= 0.8;

//Set player sprite direction
if(0 != sign(x_speed))
	image_xscale = sign(x_speed);

//Animate dodgeroll
if(move_dodge) 
{
	invincible = true;
	//set roll animation depending on dir
	if(abs(y_dir))
		sprite_index = spr_player_roll_front;
	else
		sprite_index = spr_player_roll_side;
}

//Emit particles while in roll
if(sprite_index == spr_player_roll_front or sprite_index == spr_player_roll_side)
{
	scr_make_particle0_0(x, y + 5, 2);
}

if(shoot) 
{
	var fire_rate_buff		= scr_get_item_amount(0);
	shot_dmg				= base_damage;
	bullet_cooldown			= ceil(max(20 * exp(fire_rate_buff * -0.05), 0));
	var shot_projectile		= instance_create_layer(x, y, "InstanceLayer", obj_projectile);
	shot_projectile.damage	= shot_dmg;
}

//Check for item
var colliding_instance = instance_place (x, y, obj_item);
if(colliding_instance != noone)
{
	scr_add_item(colliding_instance.item_id);
	part_particles_create(	obj_particle_system0.particle_system0, 
							colliding_instance.x, 
							colliding_instance.y, 
							obj_particle_system0.particle4, 40);
	//Update stats
	base_damage = 1 + scr_get_item_amount(1);
	
	//Send data to Server
	if(!obj_controller.is_server)
	{
		var buffer = buffer_create(4, buffer_fixed, 1);
		
		buffer_write(buffer, buffer_u8,		DATA.item_delete);
		buffer_write(buffer, buffer_u16,	colliding_instance.unique_item_id);
		buffer_write(buffer, buffer_u8,		player_id);
		
		network_send_packet(obj_controller.server, buffer, buffer_get_size(buffer));
	}
	
	//Delete instance
	instance_destroy(colliding_instance);
}


//Reduce cooldowns
dodge_cooldown		-= sign(dodge_cooldown);
bullet_cooldown		-= sign(bullet_cooldown);
damage_cooldown		-= sign(damage_cooldown);
life_bug_cooldown	-= sign(life_bug_cooldown);

//Create Buffer´
var buffer = buffer_create(16, buffer_fixed, 1);
buffer_write(buffer, buffer_u8,		DATA.player_update);
buffer_write(buffer, buffer_u8,		player_id);
buffer_write(buffer, buffer_s16,	x);
buffer_write(buffer, buffer_s16,	y);
buffer_write(buffer, buffer_s8,		image_xscale);
buffer_write(buffer, buffer_s16,	sprite_index);
buffer_write(buffer, buffer_u8,		image_index);
buffer_write(buffer, buffer_u8,		shoot);
buffer_write(buffer, buffer_u16,	shot_dmg);
buffer_write(buffer, buffer_s16,	point_direction(x, y, mouse_x, mouse_y));

//Send to server
if(obj_controller.is_server)
{
	///loop through all clients
	for(var i=0; i<ds_list_size(obj_controller.clients); i++)
	{
		//get client socket
		var soc = obj_controller.clients[| i];
		
		//Skip server player
		if(soc<0)
			continue;
			
		//Send
		network_send_packet(soc, buffer, buffer_get_size(buffer));
	}
}
else
{
	network_send_packet(obj_controller.server, buffer, buffer_get_size(buffer));
}

//Delete buffer
buffer_delete(buffer);