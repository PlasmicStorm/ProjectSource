//Destroy items that are missing on the server
if(!obj_controller.is_server) 
{
	if(!ds_map_exists(obj_controller.tracked_items, unique_item_id))
	{
		part_particles_create(	obj_particle_system0.particle_system0, 
							x, 
							y, 
							obj_particle_system0.particle4, 40);
		instance_destroy();
	}
	exit;
}

y_height++;