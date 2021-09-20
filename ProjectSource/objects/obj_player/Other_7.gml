/// @description reset roll to idle

if(dodge_status)
{
	invincible		= false;
	dodge_status	= false;
	dodge_damage	= false;
	dodge_startup	= 0;
	dodge_animation	= 0;
	sprite_index = spr_player_idle;
}
