extends "res://Scripts/entity.gd"

func _ready() -> void:
	add_to_group("sheep")

func _physics_process(delta) -> void:
	var facing = global_transform.basis.z
	move_and_slide(facing)

func _on_Timer_timeout() -> void:
	rotation_degrees.y = rad2deg(randi() % 4)
