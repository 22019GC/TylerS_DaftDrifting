extends RigidBody3D
@onready var ray_fl: RayCast3D = $RayFL
@onready var ray_fr: RayCast3D = $RayFR
@onready var ray_bl: RayCast3D = $RayBL
@onready var ray_br: RayCast3D = $RayBR
var RAY_FORCE_STRENGTH = 0.1
var RAY_FORCE_DAMPENING = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	for r : RayCast3D in [ray_bl,ray_br,ray_fl,ray_fr]:
		if r.is_colliding():
			var p := r.global_position
			var hit_p := r.get_collision_point()
			
			var hit_d := p.distance_to(hit_p)
			var spring_d := 0.8 - hit_d
			
			var pt_vel := get_point_velocity(p)
			var rel_vel := Vector3.UP.dot(pt_vel)
			
			var force := (spring_d * 0.5) - (rel_vel * 10)
		
			apply_force(Vector3.UP * force, p - global_position)
			
func get_point_velocity(point:Vector3) -> Vector3:
	return linear_velocity + angular_velocity.cross(point - to_global(center_of_mass));
