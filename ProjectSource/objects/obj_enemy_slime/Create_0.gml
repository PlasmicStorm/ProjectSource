/// @description Initialize variables

//Enemy Type
enemy_id		= scr_get_unique_enemy_id();
enemy_name		= enemy_type.slime;

//Stats
max_hp			= 10;
hp				= max_hp;
slime_cooldown	= floor(random_range(0, 100));


//Pathfinding
target_player		= noone;
target_direction	= 0;
target_range		= 300;

//Shader timing
time			= random_range(0, 100);
strength		= 0.006;

//Shader Data
distort_tex		= sprite_get_texture(spr_bump, 0);
tex_offset		= [-0.003, -0.003];
u_distort_tex	= shader_get_sampler_index(shd_distort, "distort_tex");
u_time			= shader_get_uniform(shd_distort, "time");
u_size			= shader_get_uniform(shd_distort, "size");
u_strength		= shader_get_uniform(shd_distort, "strength");
u_tex_offset	= shader_get_uniform(shd_distort, "tex_offset");