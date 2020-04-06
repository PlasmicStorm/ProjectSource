/// @description Movement and animation

//---Movement---
//Check all Keyboard inputs
if (keyboard_check(ord("W"))) 
{
	y_vel -= 0.4;
}
if (keyboard_check(ord("S"))) 
{
	y_vel += 0.4;
}
if (keyboard_check(ord("A"))) 
{
	x_vel -= 0.4;
}
if (keyboard_check(ord("D"))) 
{
	x_vel += 0.4;
}

//Decrease speed and apply to coordinates
y_vel *= 0.8;
x_vel *= 0.8;
y += y_vel;
x += x_vel;


//---Animations---
//Check if player is facing the right way
