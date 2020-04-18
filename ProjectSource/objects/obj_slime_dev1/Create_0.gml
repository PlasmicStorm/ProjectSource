/// @description Initialize variables

enemy_id		= instance_number(obj_enemy);

max_hp			= 10;
hp				= max_hp;
slime_cooldown	= floor(random_range(0, 100));
x_speed = 0;
y_speed = 0;

time			= random_range(0, 100);
strength		= 0.006;


distort_tex		= sprite_get_texture(spr_bump, 0);
tex_offset		= [-0.003, -0.003];
u_distort_tex	= shader_get_sampler_index(shd_distort, "distort_tex");
u_time			= shader_get_uniform(shd_distort, "time");
u_size			= shader_get_uniform(shd_distort, "size");
u_strength		= shader_get_uniform(shd_distort, "strength");
u_tex_offset	= shader_get_uniform(shd_distort, "tex_offset");