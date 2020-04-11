///@description adds a key time to the day and night cycle
///@param R
///@param G
///@param B
///@param con
///@param sat
///@param brt
///@param pop strength
///@param pop threshold

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

con_sat_brt[i,0] = argument3;
con_sat_brt[i,1] = argument4;
con_sat_brt[i,2] = argument5;
con_sat_brt[i,3] = argument6;
con_sat_brt[i,4] = argument7;
