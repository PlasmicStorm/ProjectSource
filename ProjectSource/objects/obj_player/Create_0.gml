/// @description Initialize variables

y_speed				= 0;
x_speed				= 0;
dodge_cooldown		= 0;
bullet_cooldown		= 0;
x_speed_multiply	= 0.3;
y_speed_multiply	= 0.2;

stasis				= false;

invincible			= false;
max_hp				= 100;
hp					= max_hp;
base_damage			= 1;
shot_dmg			= 0;
damage_cooldown		= 60;
life_bug_cooldown	= 0;

is_local			= true;
player_id			= -1;

items				= ds_grid_create(2, 0);