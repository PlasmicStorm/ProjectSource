/// @description Initialize variables

hp = 2;
slime_cooldown = floor(random_range(0, 100));
target_path = path_add();

u_brightness = shader_get_uniform(shd_passthrough, "brightness");