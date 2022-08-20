extends Spatial
var resources = {} 
var input = {}
export(int) var number_of_instances = 5
var resource_types = ["energy","water"]

func _on_gui_Click(id,type):
	print("id: " , id)
	print("type: " , type)
	input[type].append(id)
	print(input)

func generate_sequence(type):
	for i in range(number_of_instances):
		var resource = preload("res://Scenes/Resource.tscn").instance()
		var initial_position = Vector3(randi() % 15, 0.0, randi() % 15)
		resource.init(i,initial_position,type)
		resource.connect("click",self,"_on_gui_Click")

		add_child(resource)
		resources[type].append(i)

func _ready():
	for type in resource_types:
		resources[type] = []
		input[type] = []
		generate_sequence(type)
