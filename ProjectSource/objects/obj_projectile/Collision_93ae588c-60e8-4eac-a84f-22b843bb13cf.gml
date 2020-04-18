/// @description collision with enemy

//deal damage
var colliding_instance = instance_place(x, y, obj_enemy);
if(obj_controller.is_server)
	colliding_instance.hp -= damage;

//Explode into particles
part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle2, 5);

//show damage amount
var damage_number = instance_create_layer(colliding_instance.x, colliding_instance.y, "TopParticleLayer", obj_dmg_number);
damage_number.amount = damage;

instance_destroy();
