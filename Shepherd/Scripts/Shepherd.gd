extends "res://Scripts/entity.gd"

onready var mesh := $MeshInstance
onready var camera := get_node("../Camera")

func _physics_process(delta) -> void:
	control_loop(delta)

func control_loop(delta) -> void:
	var input = Vector3()
	# Player direction input
	input.z = Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forwards")
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	input = input.normalized()
	
	var dir = Vector2(input.x, input.z)
	var cardinal_direction = int(4.0 * (dir.rotated(PI / 4.0).angle() + PI) / TAU) # close approximation
	
	var angle: int
	if input != Vector3.ZERO:
		if cardinal_direction == 0:
			angle = -90
		elif cardinal_direction == 1:
			angle = 180
		elif cardinal_direction == 2:
			angle = 90
		elif cardinal_direction == 3:
			angle = 0
		
	rotation_degrees.y = rad2deg(lerp_angle(deg2rad(rotation_degrees.y), deg2rad(angle), 0.1))
	
	var direction = (camera.transform.basis.x * input.x + camera.transform.basis.z * input.z)
	
	if direction.x != 0:
		velocity.x = direction.x * ACCELERATION * delta * TARGET_FPS
	if direction.z != 0:
		velocity.z = direction.z * ACCELERATION * delta * TARGET_FPS
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 10 * delta)
		velocity.z = lerp(velocity.z, 0, 10 * delta)
		
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, 0.785398, false)
