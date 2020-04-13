/// @description Movement + Animation

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
	var fire_rate_buff	= ds_map_find_value(items, 0);
	bullet_cooldown		= ds_map_exists(items, 0) ? ceil(max(20 * exp(fire_rate_buff * -0.05), 0)) : 20;
	instance_create_layer(x, y, "InstanceLayer", obj_projectile);
}

var colliding_instance = instance_place(x, y, obj_item);
if(colliding_instance != noone)
{
	if(ds_map_exists(items, colliding_instance.item_id))
		ds_map_replace(items, colliding_instance.item_id, ds_map_find_value(items, colliding_instance.item_id) + 1);
	else
		ds_map_add(items, colliding_instance.item_id, 1);
		instance_destroy(colliding_instance);
}


//Reduce cooldowns

dodge_cooldown	-= sign(dodge_cooldown);
bullet_cooldown -= sign(bullet_cooldown);
damage_cooldown	-= sign(damage_cooldown);