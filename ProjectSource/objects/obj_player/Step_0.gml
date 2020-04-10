/// @description Movement + Animation

var move_dir_up		= keyboard_check(ord("W"));
var move_dir_down	= keyboard_check(ord("S"));
var move_dir_left	= keyboard_check(ord("A"));
var move_dir_right	= keyboard_check(ord("D"));
var move_dodge		= keyboard_check(vk_space) && dodge_cooldown = 0;

//Set temp vars for input and speed
var y_dir = move_dir_down - move_dir_up;
var x_dir = move_dir_right - move_dir_left;
y_speed += y_dir;
x_speed += x_dir;

//Do dodgeroll
if(move_dodge)
{
	if(0 == abs(y_dir) + abs(x_dir))
		x_speed = 50 * image_xscale;
	else
		x_speed = 50 * x_dir;
	y_speed = 50 * y_dir;
	dodge_cooldown = 60;
}
//Reduce roll cooldown
if(dodge_cooldown > 0)
	dodge_cooldown -= 1;

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

//--Animation--
//Set player sprite direction
if(0 != sign(x_speed))
	image_xscale = sign(x_speed);

//Animate dodgeroll
if(move_dodge) 
{
	scr_make_particle0(x, y + 5, 20);
	
	//set roll animation depending on dir
	if(abs(y_dir))
		sprite_index = spr_player_roll_front;
	else
		sprite_index = spr_player_roll_side;
}

//Emit particles while in roll
if(sprite_index == spr_player_roll_front or sprite_index == spr_player_roll_side)
{
	scr_make_particle0(x, y + 5, 5);
}