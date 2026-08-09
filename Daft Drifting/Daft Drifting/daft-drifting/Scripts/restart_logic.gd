extends Node

@onready var character_body_3d: CharacterBody3D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart"):
		GlobalVars.Restart = true
		GlobalVars.RaceTime = 0.00
		character_body_3d.global_position = Vector3.ZERO
		character_body_3d.rotation = Vector3.ZERO
		character_body_3d.speed = 0.0
		character_body_3d.velocity = Vector3.ZERO
		
