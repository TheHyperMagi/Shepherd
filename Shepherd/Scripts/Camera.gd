extends Camera

onready var sheep = $"../Sheep"

var dir = Vector3()

func _process(delta):
	print(sheep.get_property_list())
