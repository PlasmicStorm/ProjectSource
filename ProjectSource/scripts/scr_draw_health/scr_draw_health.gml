///@param max
///@param current
///@param size
function scr_draw_health(argument0, argument1, argument2) {
	var maxHP		= argument0;
	var currentHP	= argument1;
	var size		= argument2;
	if(maxHP < currentHP)
		currentHP = maxHP;
	if(currentHP < 0)
		currentHP = 0;
	var bar_offset  = (2 * size) * (1 - real(currentHP)/real(maxHP));

	//draw Back
	draw_set_color(c_black);
	draw_rectangle(x - size, y - sprite_height/2 - 1, x + size, y - sprite_height/2 - 2, false);

	//draw current
	draw_set_color(c_aqua);
	draw_rectangle(x - size, y - sprite_height/2 - 1, x + size - bar_offset, y - sprite_height/2 - 2, false);

	//draw outline
	/*
	draw_set_color(c_gray);
	draw_rectangle(x - size, y + sprite_height + 3, x + size, y + sprite_height + 1, true);
	*/

	draw_flush();


}
