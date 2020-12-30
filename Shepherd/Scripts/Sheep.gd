extends "res://Scripts/entity.gd"

func _ready():
	add_to_group("sheep")

func _physics_process(delta):
	movement_loop()
 
