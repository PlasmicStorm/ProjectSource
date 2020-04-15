image_index = round(summon_time/60 * 9);
if(summon_time == 30)
	instance_create_layer(x, y-2, "InstanceLayer", summoned_instance);
if(summon_time <= 0)
	instance_destroy();

summon_time--;