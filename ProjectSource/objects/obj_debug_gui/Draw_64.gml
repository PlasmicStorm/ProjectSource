draw_text(32, 16, "FPS = " + string(fps) + " enemys: " + string(ds_map_size(custom)));// + " " + custom);

/*
var i = 0;
for (var k = ds_map_find_first(custom); !is_undefined(k); k = ds_map_find_next(custom, k)) {
  draw_text(32, 32 + 16 * i, string(k));
  i++;
}
*/