extends KinematicBody

onready var mesh = get_node("MeshInstance")

#Movement Variables
var speed = 600
var velocity = Vector3()

#Angle Variables

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	var input = Vector3()
	if Input.is_action_pressed("move_forwards"):
		input.z += 1
	if Input.is_action_pressed("move_backwards"):
		input.z -= 1
	if Input.is_action_pressed("move_left"):
		input.x += 1
	if Input.is_action_pressed("move_right"):
		input.x -= 1
	
	input = input.normalized()
	
	if input != Vector3(0,0,0):
		rotate_from_movement(input)
	
	#var direction = (transform.basis.x * input.x + transform.basis.z * input.z)
	#velocity.x = direction.x * speed
	#velocity.z = direction.z * speed
	velocity.x = input.x * speed * delta
	velocity.z = input.z * speed * delta
	
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
