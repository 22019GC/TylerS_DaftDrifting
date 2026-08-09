extends Control

@onready var character_body_3d: CharacterBody3D = $"../.."
@onready var timer: Timer = $Timer
@onready var speed_label: RichTextLabel = $SpeedLabel
@onready var laptime_label: RichTextLabel = $LaptimeLabel
@onready var last_laptime_label: RichTextLabel = $LastLaptimeLabel
@onready var best_laptime_label: RichTextLabel = $BestLaptimeLabel

var Ready = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_label.text = str(roundi(character_body_3d.speed))
	laptime_label.text = str(GlobalVars.RaceTime)
	last_laptime_label.text = "Last:"+str(GlobalVars.PastLapTimes.back())
	best_laptime_label.text = "Best:"+str(GlobalVars.PastLapTimes.min())
	print(GlobalVars.PastLapTimes.min())
