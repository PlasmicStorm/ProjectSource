/// @description Movement + Animation

var move_dir_up		= keyboard_check(ord("W"));
var move_dir_down	= keyboard_check(ord("S"));
var move_dir_left	= keyboard_check(ord("A"));
var move_dir_right	= keyboard_check(ord("D"));
var move_dodge		= keyboard_check(vk_space) && dodge_cooldown = 0;

y_speed += move_dir_down - move_dir_up;
x_speed += move_dir_right - move_dir_left;

if(move_dodge)
{
	x_speed *= 8;
	y_speed *= 8;
	dodge_cooldown = 60;
}
if(dodge_cooldown > 0)
{
	dodge_cooldown -= 1;
}

//Collision
if(place_free(x + (x_speed * x_speed_multiply), y))
{
	x += (x_speed * x_speed_multiply);
}
if(place_free(x, y + (y_speed * y_speed_multiply)))
{
	y += (y_speed * y_speed_multiply);
}

x_speed *= 0.8;
y_speed *= 0.8;

//Animation
if(x_speed > 0) 
{
	image_xscale = 1;
}
if(x_speed < 0)
{
	image_xscale = -1;
}

if(move_dodge) {
	if(abs(x_speed) - abs(y_speed) < 0)
	{
		sprite_index = spr_player_roll_front;
	}
	else
	{
		sprite_index = spr_player_roll_side;
	}
}