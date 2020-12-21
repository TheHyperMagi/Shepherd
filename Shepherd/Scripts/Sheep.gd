extends KinematicBody

var vel = Vector3()

func _physics_process(delta):
	vel = move_and_slide(Vector3(1, -0.5, 0), Vector3(0,1,0), 0.05, 4, deg2rad(40))
	
