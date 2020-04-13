if(instance_exists(obj_player))
{
	if(true)//keyboard_check(vk_tab))
	{
		var items					= obj_player.items;
		var x_offset				= 0;
		var current_item			= ds_map_find_first(items);
		var current_item_value		= ds_map_find_value(items, current_item);
		repeat(ds_map_size(items))
		{
			draw_set_colour(c_gray);
			draw_rectangle(x_offset * 40, 0, x_offset * 40 + 42, 40, false);
			draw_set_colour(c_black);
			draw_rectangle(x_offset * 40, 0, x_offset * 40 + 42, 40, true);
			draw_sprite_ext(scr_get_item_sprite(current_item), 0, x_offset * 40 + 20, 20, 2.5, 2.5, 0, c_white, 1);
			draw_set_colour(c_red);
			draw_text(x_offset * 40 + 1, 23, string(current_item_value));
			x_offset++;
			current_item			= ds_map_find_next(items, current_item);
			current_item_value		= ds_map_find_value(items, current_item);
		}
		draw_flush();
	}
}