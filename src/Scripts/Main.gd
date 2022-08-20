extends Spatial
var resources = []
var input = []

func _on_SequenceUI_click(id):
	print(id)
	input.append(id)

func genereate_sequence():
	for i in range(3):
		var resource = preload("res://Scenes/Resource.tscn").instance()
		var initial_position = Vector3(randi() % 7, 0.0, randi() % 7)
		resource.init(i,initial_position)

		add_child(resource)
		resources.append(i)

func _ready():
	genereate_sequence()
