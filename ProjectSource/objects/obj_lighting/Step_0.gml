/// @description Calculate shader values

time += 0.001;
if(time >= 1)
	time = 0;

//get key times
key_previous	= min(floor(time * number_of_key_times), number_of_key_times -1);
key_next		= (key_previous + 1) mod number_of_key_times;

//get lerp amount
var lerp_amt	= (time - key_previous/number_of_key_times) * number_of_key_times;

//mix colours
colour_mix[0]	= lerp(colour[key_previous,0], colour[key_next,0], lerp_amt);
colour_mix[1]	= lerp(colour[key_previous,1], colour[key_next,1], lerp_amt);
colour_mix[2]	= lerp(colour[key_previous,2], colour[key_next,2], lerp_amt);

con_sat_brt_mix[0] = lerp(con_sat_brt[key_previous,0], con_sat_brt[key_next,0], lerp_amt);
con_sat_brt_mix[1] = lerp(con_sat_brt[key_previous,1], con_sat_brt[key_next,1], lerp_amt);
con_sat_brt_mix[2] = lerp(con_sat_brt[key_previous,2], con_sat_brt[key_next,2], lerp_amt);
con_sat_brt_mix[3] = lerp(con_sat_brt[key_previous,3], con_sat_brt[key_next,3], lerp_amt);
con_sat_brt_mix[4] = lerp(con_sat_brt[key_previous,4], con_sat_brt[key_next,4], lerp_amt);