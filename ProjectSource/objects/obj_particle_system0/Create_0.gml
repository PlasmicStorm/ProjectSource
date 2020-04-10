/// @description Basic smoke particles

particle_system0 = part_system_create_layer("BottomParticleLayer", false);

particle0 = part_type_create();
//Looks
part_type_shape(particle0, pt_shape_pixel);
part_type_size(particle0, 1, 4, 0.005, 0);
part_type_color1(particle0, c_white);
part_type_alpha2(particle0, 0.3, 0);
part_type_blend(particle0, false);
part_type_orientation(particle0, 0, 360, 0, 0, 0);
//Movement
part_type_speed(particle0, 0.01, 0.4, -0.1, 0);
part_type_direction(particle0, 0, 360, 0, 0);
//Other
part_type_life(particle0, 32, 60);