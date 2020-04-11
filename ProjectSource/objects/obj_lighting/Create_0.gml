//Disable automatic draw
application_surface_draw_enable(false);

//time
time = 0;

//shader
u_col = shader_get_uniform(shd_colour, "colour");

//colour variables
colour_mix		= -1;
colour[0,0]		= undefined;
key_previous	= -1;
key_next		= -1;

//arguments		  R	   G    B
scr_add_key_time(010, 070, 200); //midnight
scr_add_key_time(250, 235, 200); //dawn
scr_add_key_time(250, 240, 200); //late afternoon

number_of_key_times = array_height_2d(colour);