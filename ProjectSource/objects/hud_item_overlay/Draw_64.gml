if(instance_exists(obj_player))
{
	if(true)//keyboard_check(vk_tab))
	{
		var x_offset = 0;
		repeat(10)
		{
			draw_rectangle(x_offset*5, 0, x_offset*5 + 10, 10, false);
			x_offset++;
		}
		draw_flush();
	}
}