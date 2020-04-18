if(summon_time == 15)
	instance_create_layer(x, y-2, "InstanceLayer", summoned_instance);
if(summon_time <= 0)
	instance_destroy();
image_index = round((30 - summon_time)/30 * 6);
summon_time--;