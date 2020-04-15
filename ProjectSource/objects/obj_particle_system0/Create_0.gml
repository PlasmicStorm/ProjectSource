particle_system0 = part_system_create_layer("BottomParticleLayer", false);

#region Smoke Trail
	particle0 = part_type_create();
	//Looks
	part_type_shape(	particle0, pt_shape_pixel);
	part_type_size(		particle0, 1, 4, 0.005, 0);
	part_type_color1(	particle0, c_white);
	part_type_alpha2(	particle0, 0.3, 0);
	part_type_blend(	particle0, false);
	part_type_orientation(particle0, 0, 360, 0, 0, 0);
	//Movement
	part_type_speed(	particle0, 0.01, 0.4, -0.1, 0);
	part_type_direction(particle0, 0, 360, 0, 0);
	//Other
	part_type_life(		particle0, 32, 60);
#endregion

#region Fire Trail
	particle1 = part_type_create();
	//Looks
	part_type_shape(	particle1, pt_shape_pixel);
	part_type_size(		particle1, 1, 3, 0.005, 0);
	part_type_color_rgb(particle1, 100, 255, 0, 0, 0, 0);
	part_type_alpha2(	particle1, 1, 0);
	part_type_blend(	particle1, false);
	part_type_orientation(particle1, 0, 360, 0, 0, 0);
	//Movement
	part_type_speed(	particle1, 0.01, 0.4, -0.1, 0);
	part_type_direction(particle1, 0, 360, 0, 0);
	//Other
	part_type_life(		particle1, 32, 60);
#endregion

#region Explosion
	particle2 = part_type_create();
	//Looks
	part_type_shape(	particle2, pt_shape_pixel);
	part_type_size(		particle2, 1, 5, 0.005, 0);
	part_type_color_rgb(particle2, 100, 255, 0, 100, 0, 0);
	part_type_alpha2(	particle2, 1, 0);
	part_type_blend(	particle2, true);
	//Movement
	part_type_speed(	particle2, 1, 4, -0.3, 0);
	part_type_direction(particle2, 0, 360, 0, 0);
	//Other
	part_type_life(		particle2, 32, 60);
#endregion

#region Blood
	particle3 = part_type_create();
	//Looks
	part_type_shape(	particle3, pt_shape_pixel);
	part_type_size(		particle3, 1, 4, 0, 0);
	part_type_color_rgb(particle3, 100, 150, 0, 0, 0, 0);
	part_type_alpha2(	particle3, 0.9, 0.9);
	//Movement
	part_type_speed(	particle3, 0, 1, -0.4, 0);
	part_type_direction(particle3, 0, 180, 0, 0);
	//Other
	part_type_life(		particle3, 3200, 6000);
#endregion

#region Colour Explosion
	particle4 = part_type_create();
	//Looks
	part_type_shape(	particle4, pt_shape_pixel);
	part_type_size(		particle4, 0.5, 2, 0.005, 0);
	part_type_color_rgb(particle4, 0, 255, 0, 255, 0, 255);
	part_type_alpha2(	particle4, 1, 0);
	part_type_blend(	particle4, true);
	//Movement
	part_type_speed(	particle4, 0.5, 3, -0.2, 0);
	part_type_direction(particle4, 0, 360, 0, 0);
	//Other
	part_type_life(		particle4, 32, 60);
#endregion

#region Colour
	particle5 = part_type_create();
	//Looks
	part_type_shape(	particle5, pt_shape_pixel);
	part_type_size(		particle5, 0.5, 2, 0.005, 0);
	part_type_color_rgb(particle5, 0, 255, 0, 255, 0, 255);
	part_type_alpha2(	particle5, 1, 0);
	part_type_blend(	particle5, true);
	//Movement
	part_type_speed(	particle5, 1, 2, -0.2, 0);
	part_type_direction(particle5, 0, 180, 0, 0);
	part_type_gravity(	particle5, 0.1, 90);
	//Other
	part_type_life(		particle5, 32, 60);
#endregion