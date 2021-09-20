///@param size
///@param x_offset
///@param y_offset
///@param strength
///@param invert
function scr_draw_shadow(argument0, argument1, argument2, argument3, argument4) {

	var size		= argument0;
	var x_offset	= argument1;
	var y_offset	= argument2;
	var strength	= argument3;
	var invert		= argument4;
	var skew		= sign(sprite_width) == -1 ? sprite_width *-1 : 0;

	draw_sprite_ext(sprite_index, 
					image_index, 
					x + x_offset, 
					y + sprite_height - (1 - size) * (sprite_height/2) + y_offset,  
					image_xscale, 
					-1 * size * (invert ? -1 : 1),
					0, 
					c_black, 
					strength);
	draw_flush();
	/*
	shader_set(shd_draw_black);
	draw_sprite_pos(sprite_index, 
					image_index, 
					x + x_offset,					y + y_offset,
					x + x_offset + sprite_width/2,	y + y_offset, 
					x + x_offset,							y + y_offset + size, 
					x + x_offset - sprite_width/2,			y + y_offset + size, 
					strength);
	shader_reset();

/* end scr_draw_shadow */
}
