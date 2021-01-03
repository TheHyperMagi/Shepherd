extends KinematicBody

var TYPE = "SHEEP"
var SPEED = 600
var VELOCITY = Vector3()

func movement_loop():
	move_and_slide(Vector3(1, -0.5, 0), Vector3(0,1,0), 0.05, 4, deg2rad(40))
