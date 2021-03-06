time			= random(100);
strength		= 0.006;

distort_tex		= sprite_get_texture(spr_wave, 0);
tex_offset		= [-0.003, -0.003];
u_distort_tex	= shader_get_sampler_index(shd_distort, "distort_tex");
u_time			= shader_get_uniform(shd_distort, "time");
u_size			= shader_get_uniform(shd_distort, "size");
u_strength		= shader_get_uniform(shd_distort, "strength");
u_tex_offset	= shader_get_uniform(shd_distort, "tex_offset");