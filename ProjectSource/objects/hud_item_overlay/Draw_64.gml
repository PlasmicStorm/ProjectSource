if(instance_exists(obj_player))
{
	
	if(keyboard_check(vk_tab))
	{
		var items					= obj_player.items;
		var x_offset				= 0;
		repeat(ds_grid_height(items))
		{
			//Draw Back
			draw_set_colour(c_gray);
			draw_rectangle(x_offset * 40, 0, x_offset * 40 + 42, 40, false);
			draw_set_colour(c_black);
			draw_rectangle(x_offset * 40, 0, x_offset * 40 + 42, 40, true);
			//Draw item
			draw_sprite_ext(scr_get_item_sprite(ds_grid_get(items, 0, x_offset)), 0, x_offset * 40 + 20, 20, 2.5, 2.5, 0, c_white, 1);
			draw_set_colour(c_red);
			draw_text(x_offset * 40 + 1, 23, string(ds_grid_get(items, 1, x_offset)));
			//get next item
			x_offset++;
		}
		draw_flush();
	}
}