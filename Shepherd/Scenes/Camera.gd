extends Camera

export onready var target = get_node("../Shepherd")

export var offset := Vector3(20, 10, 20)
export var zoom_in_limit := 10.0
export var zoom_out_limit := 40.0

# Called when the node enters the scene tree for the first time.
func _ready():
	translation = target.translation + offset
	look_at_target()

func _process(delta):
	zoom_input()
	translation = target.translation + offset

func look_at_target():
	look_at(target.translation, Vector3.UP)

# Zoom in and out by moving the camera's offset with lerp
func zoom_input():
	if Input.is_action_just_released("zoom_in"):
		if translation.distance_to(target.translation) > zoom_in_limit:
			offset = lerp(offset, Vector3.ZERO, 0.1)
			look_at_target()
	if Input.is_action_just_released("zoom_out"):
		if translation.distance_to(target.translation) < zoom_out_limit:
			offset = lerp(offset, Vector3.ZERO, -0.1)
			look_at_target()
