extends Node3D
@onready var start_area_3d: Area3D = $"Start Area3d"
@onready var end_area_3d: Area3D = $"End Area3d"
@onready var timer: Timer = $Timer
@onready var green_box: CSGBox3D = $"Start Area3d/CollisionShape3D/CSGBox3D"
@onready var red_box: CSGBox3D = $"End Area3d/CollisionShape3D/CSGBox3D"



var time = 0.00
var TimerRunning = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	green_box.visible = false
	red_box.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_Timer()
	
	if GlobalVars.Restart == true:
		TimerRunning = false
		GlobalVars.Restart = false 
		time = 0.0




func _on_start_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		time = 0.00
		GlobalVars.Restart = false
		TimerRunning = true
	

func _Timer():
	if TimerRunning == true:
		await get_tree().create_timer(0.01).timeout
		time += 0.01
		GlobalVars.RaceTime = "%.2f" % time
	


func _on_end_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		green_box.visible = true
		red_box.visible = false
		var temp_min = 5.0
		#final min = 0.0
		if time>temp_min and GlobalVars.Restart==false:
			GlobalVars.PastLapTimes.append(snapped(time, 0.01))
		TimerRunning = false
		

func _on_start_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		red_box.visible = true
		green_box.visible = false
