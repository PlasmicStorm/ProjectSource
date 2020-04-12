/// @description reset roll to idle

if(sprite_index == spr_player_roll_front or sprite_index == spr_player_roll_side)
{
	invincible = false;
	sprite_index = spr_player_walk;
}
