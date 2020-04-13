///@param size
///@param offset
///@param strength

size	= argument0;
offset	= argument1;
strength= argument2;

draw_sprite_ext(sprite_index, image_index, x, y + sprite_height + offset - (1 - size) * sprite_height/2, image_xscale, image_yscale * -1 * size, 0, c_black, strength);