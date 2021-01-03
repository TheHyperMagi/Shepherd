extends "res://Scripts/entity.gd"

onready var mesh = $MeshInstance
onready var detection = $Detection
onready var camera = get_node("../Camera")

var speed = 1
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
	
	if input != Vector3(0,0,0):
		rotate_from_movement(input)
	
	var direction = (camera.transform.basis.x * input.x + camera.transform.basis.z * input.z)
	
	velocity.x = direction.x * SPEED * delta
	velocity.z = direction.z * SPEED * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)

func rotate_from_movement(input):
#Calculates angle based on movement (currently hardcoded but its good enough for me)
	var desired_angle = 0
	
	#Calculates for one direction
	if input.z > 0:
		desired_angle = 180
	elif input.z < 0:
		desired_angle = 0
	if input.x > 0:
		desired_angle = 270
	elif input.x < 0:
		desired_angle = 90
	
	#Calculates for diagonals
	if input.x != 0 && input.z != 0:
		desired_angle = rad2deg(atan(input.z/input.x))
		if input.z > 0:
			desired_angle += 180
		
	desired_angle += 45
	
	#Smooth angle change
	rotation_degrees.y = rad2deg(lerp_angle(deg2rad(rotation_degrees.y), deg2rad(desired_angle), 0.1))
