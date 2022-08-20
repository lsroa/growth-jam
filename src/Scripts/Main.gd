extends Spatial
var resources = {} 
var input = {}
export(int) var number_of_instances = 5
export(int) var number_of_instances_adjacent_building = 4
var resource_types = ["oil", "power", "water", "solar"]

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
		for building in range(number_of_instances_adjacent_building):
			var adjacent_position = adjacent_coordinates(initial_position, building)
			var adjacent_building = preload("res://Scenes/AdjacentBuilding.tscn").instance()
			adjacent_building.init(i,adjacent_position,type)
			adjacent_building.connect("click",self,"_on_gui_Click")
			add_child(adjacent_building)
			
func adjacent_coordinates(initial_position, building):
	var initial_adjacent_position = Vector3(0,0,0)
	if (building == 0):
		initial_adjacent_position = Vector3(
			initial_position.x + 2, 
			initial_position.y, 
			initial_position.z
		)
	elif(building == 1):
		initial_adjacent_position = Vector3(
			initial_position.x - 2, 
			initial_position.y, 
			initial_position.z 
		)
	elif(building == 2):
		initial_adjacent_position = Vector3(
			initial_position.x - 0.5, 
			initial_position.y, 
			initial_position.z - 2
		)
	else:
		initial_adjacent_position = Vector3(
			initial_position.x, 
			initial_position.y, 
			initial_position.z + 2
		)
	return initial_adjacent_position
 
func _ready():
	for type in resource_types:
		resources[type] = []
		input[type] = []
		generate_sequence(type)
