if(parameter_count() == 3) {
	/*
	execute_shell(	parameter_string(0) + " " +
					parameter_string(1) + " " +
					parameter_string(2) + " " +
					parameter_string(3) + " -secondary - tertiary", false);
					/*
	execute_shell(	parameter_string(0) + " " +
					parameter_string(1) + " " +
					parameter_string(2) + " " +
					parameter_string(3) + " -secondary - tertiary", false);
					/*
	execute_shell(	parameter_string(0) + " " +
					parameter_string(1) + " " +
					parameter_string(2) + " " +
					parameter_string(3) + " -secondary - tertiary", false);
					*/
	window_set_caption("P1");
	window_set_position(200, 260);
}

if(parameter_count() > 3) {
	window_set_caption("P2")
	
	window_set_position(900, 260);
}