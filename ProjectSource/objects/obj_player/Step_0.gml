/// @description Insert description here

var move_dir_up		= keyboard_check(ord("W"));
var move_dir_down	= keyboard_check(ord("S"));
var move_dir_left	= keyboard_check(ord("A"));
var move_dir_right	= keyboard_check(ord("D"));

y_speed += move_dir_down - move_dir_up;
x_speed += move_dir_right - move_dir_left;

//Collision
if(place_free(x + x_speed, y))
{
	x += x_speed * 0.5;
}
if(place_free(x, y + y_speed))
{
	y += y_speed * 0.4;
}


x_speed *= 0.8;
y_speed *= 0.8;