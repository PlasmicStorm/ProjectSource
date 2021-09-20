///@param itemId
function scr_add_item(argument0) {
	item_id = argument0;

	var item_exists = false;
	var i = 0;

	repeat(ds_grid_height(items))
	{
		if(ds_grid_get(items, 0, i) == item_id)
		{
			item_exists = true;
			break;
		}
		i++;
	}
	if(item_exists)
	{
		ds_grid_set(items, 1, i, ds_grid_get(items, 1, i) + 1);
		return;
	}

	ds_grid_resize(items, 2, ds_grid_height(items) + 1);
	ds_grid_add(items, 0, ds_grid_height(items) - 1, item_id);
	ds_grid_add(items, 1, ds_grid_height(items) - 1, 1);


}
