/// @description Initialize variables

//Variables and cooldowns
y_speed				= 0;
x_speed				= 0;
dodge_cooldown		= 0;
dodge_animation		= 0;
dodge_status		= false;
dodge_startup		= 0;
dodge_damage		= false;
bullet_cooldown		= 0;
x_speed_multiply	= 0.3;
y_speed_multiply	= 0.2;
stasis				= false;
alive				= true;

//Stats
invincible			= false;
max_hp				= 100;
hp					= max_hp;
base_damage			= 100;
shot_dmg			= 0;
damage_cooldown		= 60;
life_bug_cooldown	= 0;

//Networking
is_local			= true;
player_id			= -1;

//Items
items				= ds_grid_create(2, 0);
collected_items		= ds_list_create();