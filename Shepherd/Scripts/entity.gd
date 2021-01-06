extends KinematicBody

export var ACCELERATION := 8
export var TARGET_FPS := 60
var GRAVITY : int = ProjectSettings.get_setting("physics/3d/default_gravity") # get from the project settings
var velocity := Vector3()
const MAX_SPEED := 64

func _physics_process(delta) -> void:
	velocity.y -= GRAVITY * delta * TARGET_FPS
	move_and_slide(velocity, Vector3.UP)
