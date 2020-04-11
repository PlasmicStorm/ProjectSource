shader_set(shd_colour);
shader_set_uniform_f_array(u_col, colour_mix);
draw_surface(application_surface, 0, 0);
shader_reset();