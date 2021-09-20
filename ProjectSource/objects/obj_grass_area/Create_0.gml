/// @description Initialize grass region
sprite	= spr_grass_small;
frames	= sprite_get_number(sprite);
texture = sprite_get_texture(sprite, 0);
width	= sprite_get_width(sprite);
height	= sprite_get_height(sprite);

//Grass
grassCount = (image_xscale * image_yscale) * 100 + 1;

color = c_white;
alpha = 1;

// 3D
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();

format = vertex_format_end();
vbuff = vertex_create_buffer();

vertex_begin(vbuff, format);

repeat (grassCount) {
	//Grass coordinates
	var x0 = irandom_range(bbox_left, bbox_right);
	var y0 = irandom_range(bbox_top, bbox_bottom);
	var x1 = x0 + width;
	var y1 = y0 + height;
	
	var _depth = room_height-y1+(height/2);
	
	//Texture coordinates
	var _frame = irandom(frames - 1);
	var _uvs = sprite_get_uvs(sprite, _frame);
	
	//Triangle 1
	vertex_position_3d(vbuff, x0, y0, _depth);
	vertex_texcoord(vbuff, _uvs[0], _uvs[1]);
	vertex_color(vbuff, color, alpha);
	
	vertex_position_3d(vbuff, x1, y0, _depth);
	vertex_texcoord(vbuff, _uvs[2], _uvs[1]);
	vertex_color(vbuff, color, alpha);
	
	vertex_position_3d(vbuff, x0, y1, _depth);
	vertex_texcoord(vbuff, _uvs[0], _uvs[3]);
	vertex_color(vbuff, color, alpha);
	
	//Triangle 2
	vertex_position_3d(vbuff, x1, y0, _depth);
	vertex_texcoord(vbuff, _uvs[2], _uvs[1]);
	vertex_color(vbuff, color, alpha);
	
	vertex_position_3d(vbuff, x0, y1, _depth);
	vertex_texcoord(vbuff, _uvs[0], _uvs[3]);
	vertex_color(vbuff, color, alpha);
	
	vertex_position_3d(vbuff, x1, y1, _depth);
	vertex_texcoord(vbuff, _uvs[2], _uvs[3]);
	vertex_color(vbuff, color, alpha);
}

vertex_end(vbuff);
vertex_freeze(vbuff);