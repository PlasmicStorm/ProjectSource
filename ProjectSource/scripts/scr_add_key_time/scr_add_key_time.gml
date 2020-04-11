///scr_add_key_time(R,G,B);

if (is_undefined(colour[0,0]))
{
	var i = 0;
} else 
{
	var i = array_height_2d(colour);
}

colour[i,0] = argument0/255;
colour[i,1] = argument1/255;
colour[i,2] = argument2/255;
