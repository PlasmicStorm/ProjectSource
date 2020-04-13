/// @description Basic smoke particles

particle_system0 = part_system_create_layer("TopParticleLayer", false);
#region Slime explosion
	particle0 = part_type_create();

	//Looks
	part_type_shape(	particle0, pt_shape_pixel);
	part_type_size(		particle0, 2, 10, -0.2, 0);
	part_type_color1(	particle0, c_green);
	part_type_alpha2(	particle0, 0.5, 0);
	part_type_blend(	particle0, false);
	part_type_orientation(particle0, 0, 360, 0, 1, 0);
	//Movement
	part_type_speed(	particle0, 0.4, 0.8, 0, 0);
	part_type_direction(particle0, 0, 180, 0, 0);
	part_type_gravity(	particle0, 0.1, 270);
	//Other
	part_type_life(		particle0, 20, 30);
#endregion

#region Blood splatter
	particle1 = part_type_create();
	//Looks
	part_type_shape(	particle1, pt_shape_pixel);
	part_type_size(		particle1, 1, 5, 0, 0);
	part_type_color_rgb(particle1, 100, 255, 0, 0, 0, 0);
	part_type_alpha2(	particle1, 1, 0);
	part_type_orientation(particle1, 0, 360, 0, 0, 0);
	//Movement
	part_type_speed(	particle1, 0.5, 2, -0.05, 0);
	part_type_direction(particle1, 0, 180, 0, 0);
	part_type_gravity(	particle1, 0.1, 270);
	//Other
	part_type_life(		particle1, 10, 30);
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