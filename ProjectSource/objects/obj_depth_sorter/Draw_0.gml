/// @description sort objects by Y coordinate and draw them in order

//resize grid
var dgrid = ds_depthgrid;
var inst_num = instance_number(par_depth_object);
ds_grid_resize(dgrid, 2, inst_num);

//add all instances to grid
var yy = 0; 
with(par_depth_object)
{
	dgrid[# 0, yy] = id;
	dgrid[# 1, yy] = y;
	yy++;
}

//sort the grid by y
ds_grid_sort(dgrid, 1, true);

var inst;
yy = 0;
repeat(inst_num)
{
	inst = dgrid[# 0, yy];
	
	with(inst)
	{
		draw_self();
	}
	yy++;
}