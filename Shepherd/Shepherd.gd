extends KinematicBody

onready var mesh = get_node("MeshInstance")

#Movement Variables
var speed = 10
var velocity = Vector3()

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	var input = Vector3()
	if Input.is_action_pressed("move_forwards"):
		input.z -= 1
	if Input.is_action_pressed("move_backwards"):
		input.z += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	input = input.normalized()
	
	rotate_from_movement(input)
	
	#var direction = (transform.basis.x * input.x + transform.basis.z * input.z)
	#velocity.x = direction.x * speed
	#velocity.z = direction.z * speed
	velocity.x = input.x * speed
	velocity.z = input.z * speed
	
	velocity = move_and_slide(velocity, Vector3.UP)


func rotate_from_movement(input):
#Calculates angle based on movement (currently hardcoded but its good enough for me)
	#Calculates for one direction
	if input.z > 0:
		rotation_degrees.y = 0
	elif input.z < 0:
		rotation_degrees.y = 180
	if input.x > 0:
		rotation_degrees.y = 90
	elif input.x < 0:
		rotation_degrees.y = 270
	
	#Calculates for axis
	if input.x != 0 && input.z != 0:
		rotation_degrees.y = rad2deg(atan(input.z/input.x))
		if input.z < 0:
			rotation_degrees.y += 180
