extends KinematicBody

export var ACCELERATION := 8
export var VELOCITY := Vector3()
export var TARGET_FPS := 60
export var GRAVITY :=  4

const MAX_SPEED = 64

func movement_loop():
	move_and_slide(Vector3(1, -0.5, 0), Vector3(0,1,0), 0.05, 4, deg2rad(40))
