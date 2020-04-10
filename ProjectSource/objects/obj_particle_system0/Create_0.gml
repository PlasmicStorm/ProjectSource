/// @description Insert description here
// You can write your code in this editor

particle_system0 = part_system_create_layer("BottomParticleLayer", false);

particle0 = part_type_create();
//Looks
part_type_shape(particle0, pt_shape_smoke);
part_type_size(particle0, 0.1, 0.2, 0.001, 0);
part_type_color1(particle0, c_black);
part_type_alpha2(particle0, 0.8, 0);
part_type_blend(particle0, false);
part_type_orientation(particle0, 0, 360, 0, 0, 0);
//Movement
part_type_speed(particle0, 0.01, 0.4, -0.1, 0);
part_type_direction(particle0, 0, 360, 0, 0);
//Other
part_type_life(particle0, 32, 60);