extends Spatial
var resources = {} 
var input = {}
export(int) var number_of_instances_main_building = 9
export(int) var number_of_instances_adjacent_building = 4
export(int) var gap = 10
var resource_types = ["oil", "power", "water", "solar"]

func _on_gui_Click(id):
	print("id: " , id)
#	input[type].append(id)
	print(input)

func main_building_coordidate(i, j):
	var resource = preload("res://Scenes/Resource.tscn").instance()
	var initial_position = Vector3(i * gap, 0, -j * gap)
	resource.init(str(i,j),initial_position)
	resource.connect("click",self,"_on_gui_Click")
	add_child(resource)

	for building in range(number_of_instances_adjacent_building):
		var adjacent_position = adjacent_coordinates(initial_position, building)
		var adjacent_building = preload("res://Scenes/AdjacentBuilding.tscn").instance()
		adjacent_building.init(str(i,j,building), adjacent_position)
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
	for i in range(3):
		for j in range(3):
			main_building_coordidate(i, j)
