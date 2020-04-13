/// @description collision with enemy

var colliding_instance = instance_place(x, y, obj_slime_dev);
colliding_instance.hp -= damage;
part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle2, 5);
var damage_number = instance_create_layer(colliding_instance.x, colliding_instance.y, "TopParticleLayer", obj_dmg_number);
damage_number.amount = damage;
instance_destroy();