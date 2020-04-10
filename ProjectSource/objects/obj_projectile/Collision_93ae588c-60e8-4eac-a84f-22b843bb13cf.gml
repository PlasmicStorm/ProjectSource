/// @description collision with enemy

var colliding_instance = instance_place(x, y, obj_slime_dev);
colliding_instance.hp -= damage;
part_particles_create(obj_particle_system1.particle_system0, x, y, obj_particle_system1.particle2, 5);
instance_destroy();