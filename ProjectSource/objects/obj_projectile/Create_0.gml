/// @description Initialize variables

image_xscale = 0.5;
image_yscale = 0.5;

projectile_speed = 5;
damage = 1;
if(instance_exists(obj_player))
	damage = obj_player.base_damage;
show_debug_message(string(damage));

direction = point_direction(x, y, mouse_x, mouse_y);
speed = projectile_speed;