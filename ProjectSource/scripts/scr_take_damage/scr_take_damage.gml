///@param damage
///@param player_id
function scr_take_damage(argument0, argument1) {

	var damage			= argument0;
	var player_dmg_id	= argument1;

	//show_debug_message("damage should be calculated. Cooldown: " + string(damage_cooldown) + " invincible? " + string(invincible));
	if(damage_cooldown == 0 && !invincible)
	{
		hp -= damage;
		damage_cooldown = 60;
		//create blood particles
		part_particles_create(	obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle1, 20);
		repeat(20)
		{
			part_particles_create(	obj_particle_system0.particle_system0,
								x + random_range(-4, 4),
								y + 16 + random(2),
								obj_particle_system0.particle3, 1);
		}
	}

	if(obj_controller.is_server && player_dmg_id != 0)
	{
		var buffer = buffer_create(4, buffer_fixed, 1);
	
		buffer_write(buffer, buffer_u8, DATA.player_damage);
		buffer_write(buffer, buffer_u16, damage);
		buffer_write(buffer, buffer_u8, player_id);
	
		scr_net_send_to_client(buffer, player_dmg_id);
	}


}
