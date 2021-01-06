extends "res://Scripts/entity.gd"

onready var mesh := $MeshInstance
onready var camera := get_node("../Camera")

func _physics_process(delta) -> void:
	control_loop(delta)

func control_loop(delta) -> void:
	var input = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forwards")
		).normalized()

	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 10 * delta)
		velocity.z = lerp(velocity.z, 0, 10 * delta)
		
	var direction = (camera.transform.basis.x * input.x + camera.transform.basis.z * input.z)
	
	if direction:
		velocity.x = direction.x * ACCELERATION * delta * TARGET_FPS
		velocity.z = direction.z * ACCELERATION * delta * TARGET_FPS
		var angle = stepify(atan2(-direction.x, -direction.z), deg2rad(45))
		rotation.y = lerp_angle(rotation.y, angle, delta * 5.0)

	velocity = move_and_slide(velocity)
