extends CharacterBody3D

const normal_turn_speed = 2
const drift_turn_speed = 4
var turn_speed = normal_turn_speed

const max_speed = 300.0
const min_speed = 30.0
const max_drift_speed = 15.0
const min_drift_speed = 5.0
const reverse_speed = 10.0

var speed = 0.0
const jump_velocity = 4.5

func _physics_process(delta: float) -> void:
	
	
	if is_on_wall():
		velocity.x = lerp(velocity.x, 0.0, 1.0*delta)
		velocity.z = lerp(velocity.z, 0.0, 1.0*delta)
		speed = lerp(speed, reverse_speed, 10.0*delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta *3

	if Input.is_action_pressed("Drift"):
		if speed>0.0:
			speed = lerpf(speed, 0.0, delta / speed)
			turn_speed = drift_turn_speed
	elif Input.is_action_pressed("Backward") and not Input.is_action_pressed("Forward"):
		speed = lerp(speed, reverse_speed, 20.0 * delta)
	elif Input.is_action_pressed("Forward") and not Input.is_action_pressed("Backward"):
		var speed_change = (0.001)-(speed/max_speed/1000)*delta
		speed = lerpf(speed, max_speed, speed_change)
		turn_speed = normal_turn_speed
	else:
		speed = lerp(speed, 0.0, delta)

	var input_dir := Input.get_vector("", "", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if input_dir == Vector2(0.0, 1.0):
			velocity.x = lerp(velocity.x,direction.x * round(speed), 1.5 * delta)
			velocity.z = lerp(velocity.z,direction.z * round(speed), 1.5 * delta)
		else:
			velocity.x = lerp(velocity.x,direction.x * round(speed), 10.0 * delta)
			velocity.z = lerp(velocity.z,direction.z * round(speed), 10.0 * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, 4.0 * delta)
		velocity.z = lerp(velocity.z, 0.0, 4.0 * delta)


	var input_rot := Input.get_axis("Left","Right")
	if round(sqrt(velocity.x*velocity.x))>0 or round(sqrt(velocity.z*velocity.z))>0:
		rotation.y = lerp(rotation.y, -45*input_rot*turn_speed, 0.02*delta)
	move_and_slide()
