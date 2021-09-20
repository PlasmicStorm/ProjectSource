function scr_get_unique_enemy_id() {
	var new_id;
	with obj_summon_controller
	{
		new_id = unique_enemy_id;
		unique_enemy_id++;
	}

	return new_id;


}
