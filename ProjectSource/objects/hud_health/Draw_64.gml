/// @description Insert description here

draw_text(32, 32, "depth: " + string(obj_player.depth));


var xx = 1;
if(instance_exists(obj_player))
{
	var x_offset = surface_get_width(application_surface) - ((obj_player.max_hp * 2) + 4) * hudscale;
	var y_offset = 0;
	
	draw_sprite_ext(spr_health, 0, x_offset, y_offset, hudscale, hudscale,0,c_white,1);
	repeat(obj_player.max_hp)
	{
		if(obj_player.max_hp - xx + 1 > obj_player.hp)
			draw_sprite_ext(spr_health, 1, x_offset + xx * 2 * hudscale, y_offset, hudscale, hudscale,0,c_white,1);
		else
			draw_sprite_ext(spr_health, 2, x_offset + xx * 2 * hudscale, y_offset, hudscale, hudscale,0,c_white,1);
		xx++;
	}
	draw_sprite_ext(spr_health, 3, x_offset + xx * 2 * hudscale, y_offset, hudscale, hudscale,0,c_white,1);
}