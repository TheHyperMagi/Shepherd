extends "res://Scripts/entity.gd"

onready var mesh = get_node("MeshInstance")

var velocity = Vector3()

func _physics_process(delta):
	control_loop(delta)

func control_loop(delta):
	var input = Vector3()
	
	# Player direction input
	if Input.is_action_pressed("move_forwards"):
		input.z -= 1
	if Input.is_action_pressed("move_backwards"):
		input.z += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	input = input.normalized()
	
#	if input != Vector3(0,0,0):
#		rotate_from_movement(input)

	velocity = input * SPEED * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)

func rotate_from_movement(input):
#Calculates angle based on movement (currently hardcoded but its good enough for me)
	var desired_angle = 0
	
	#Calculates for one direction
	if input.z > 0:
		desired_angle = 0
	elif input.z < 0:
		desired_angle = 180
	if input.x > 0:
		desired_angle = 90
	elif input.x < 0:
		desired_angle = 270
	
	#Calculates for diagonals
	if input.x != 0 && input.z != 0:
		desired_angle = rad2deg(atan(input.z/input.x))
		if input.z < 0:
			desired_angle += 180
		
	
	#Smooth angle change
	rotation_degrees.y = rad2deg(lerp_angle(deg2rad(rotation_degrees.y), deg2rad(desired_angle), 0.1))
