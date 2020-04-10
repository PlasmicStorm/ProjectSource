/// @description Bullet trail

particle_system1 = part_system_create_layer("BottomParticleLayer", false);

particle1 = part_type_create();
//Looks
part_type_shape(particle1, pt_shape_pixel);
part_type_size(particle1, 1, 3, 0.005, 0);
part_type_color_rgb(particle1, 100, 255, 0, 0, 0, 0);
part_type_alpha2(particle1, 1, 0);
part_type_blend(particle1, false);
part_type_orientation(particle1, 0, 360, 0, 0, 0);
//Movement
part_type_speed(particle1, 0.01, 0.4, -0.1, 0);
part_type_direction(particle1, 0, 360, 0, 0);
//Other
part_type_life(particle1, 32, 60);