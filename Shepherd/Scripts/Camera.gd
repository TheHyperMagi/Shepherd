extends Camera

onready var sheep = get_node("../Sheep")

func _process(delta):
	transform.looking_at(sheep.global_transform.origin, Vector3(0,1,0))	
