extends Node3D
@onready var Movement: CharacterBody3D = $".."
@onready var tire_fl: MeshInstance3D = $"TaxiCarV2/Tire FL"
@onready var tire_fr: MeshInstance3D = $"TaxiCarV2/Tire FR"
@onready var tire_br: MeshInstance3D = $"TaxiCarV2/Tire BR"
@onready var tire_bl: MeshInstance3D = $"TaxiCarV2/Tire BL"
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var gpu_particles_3d_2: GPUParticles3D = $GPUParticles3D2


const drift_turn_amount = 60
const normal_turn_amount = 25
var turn_amount = normal_turn_amount
var slide_amount = turn_amount/6
@onready var collision_shape_3d: CollisionShape3D = $"../CollisionShape3D"

func _physics_process(delta: float) -> void:
	tire_fr.rotation = rotation*1.3
	tire_fl.rotation = rotation*1.3

	collision_shape_3d.rotation = rotation
	
	if Movement.is_on_wall():
		pass
		#play crash animation
	
	if Input.is_action_pressed("Drift"):
		turn_amount = drift_turn_amount
	else:
		turn_amount = normal_turn_amount
	
	var input_rot := Input.get_axis("Left","Right")
	var input_dir := -Input.get_axis("Forward","Backward")
	#if sqrt(Movement.velocity.x*Movement.velocity.x) > 0:
	if GlobalVars.Restart == true:
		rotation.y = move_toward(rotation.y, deg_to_rad(0), 3*delta)
	else:
		match input_rot:
			-1.0:
				rotation.y = lerp(rotation.y, deg_to_rad(turn_amount*input_dir), slide_amount*delta)
			1.0:
				rotation.y = lerp(rotation.y, deg_to_rad(-turn_amount*input_dir), slide_amount*delta)
			0.0:
				rotation.y = move_toward(rotation.y, deg_to_rad(0), 3*delta)
