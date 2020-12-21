extends KinematicBody

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
	
	var direction = (transform.basis.x * input.x + transform.basis.z * input.z)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	velocity = move_and_slide(velocity, Vector3.UP)


