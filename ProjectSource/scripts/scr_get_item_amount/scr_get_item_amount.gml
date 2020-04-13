///@param item_id

item_id = argument0;

var i = 0;
repeat(ds_grid_height(items))
{
	if(ds_grid_get(items, 0, i) == item_id)
	{
		return ds_grid_get(items, 1, i);
	}
	i++;
}
return 0;