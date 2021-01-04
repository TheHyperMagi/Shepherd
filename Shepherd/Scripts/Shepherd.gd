extends "res://Scripts/entity.gd"

onready var mesh := $MeshInstance
onready var camera := get_node("../Camera")

func _physics_process(delta) -> void:
	control_loop(delta)

func control_loop(delta) -> void:
	var input = Vector3()
	# Player direction input
	input.z = Input.get_action_strength("move_forwards") - Input.get_action_strength("move_backwards")
	input.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	
	input = input.normalized()
	
	var dir = Vector2(input.x, input.z)
	var cardinal_direction = int(4.0 * (dir.rotated(PI / 4.0).angle() + PI) / TAU) # close approximation
	
	#forward 3
	#back 1
	#right 0
	#left 2
	
	var angle: int
	
	if cardinal_direction == 0:
		angle = -90
	elif cardinal_direction == 1:
		angle = 180
	elif cardinal_direction == 2:
		angle = 90
	elif cardinal_direction == 3:
		angle = -180
		
	rotation_degrees.y = rad2deg(lerp_angle(deg2rad(rotation_degrees.y), deg2rad(angle), 0.1))
	
	if input.x != 0:
		velocity.x = input.x * ACCELERATION * delta * TARGET_FPS
	if input.z != 0:
		velocity.z = input.z * ACCELERATION * delta * TARGET_FPS
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 10 * delta)
		velocity.z = lerp(velocity.z, 0, 10 * delta)
		
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, 0.785398, false)
