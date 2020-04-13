/// @description Initialize variables

image_xscale = 0.5;
image_yscale = 0.5;

projectile_speed = 5;
damage = 1;
if(instance_exists(obj_player))
	if(ds_map_exists(obj_player.items, 1))
		damage = 1 + ds_map_find_value(obj_player.items, 1);

direction = point_direction(x, y, mouse_x, mouse_y);
speed = projectile_speed;