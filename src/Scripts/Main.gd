extends Spatial
var resources = {} 
var input = {}
export(int) var number_of_instances_main_building = 9
#export(int) var number_of_instances_adjacent_building = 3
export(int) var main_building_gap = 8
var resource_types = ["oil", "power", "water", "solar"]
var adjancent_building_positions = ["left", "right", "up", "down"]

func _on_gui_Click(id):
	print("id: " , id)
#	input[type].append(id)
	print(input)

func main_building_coordidate(i, j):
	var resource = preload("res://Scenes/Resource.tscn").instance()
	var initial_position = Vector3(i * main_building_gap, 0, -j * main_building_gap)
	resource.init(str(i,j),initial_position)
	resource.connect("click",self,"_on_gui_Click")
	add_child(resource)
	
	var random_number = rand_range(0, adjancent_building_positions.size())
	# TODO: This random rule needs to be improved
	var random_adjancent_building_positions = adjancent_building_positions.slice(random_number - 1, random_number)

	for adjancent_building_position in random_adjancent_building_positions:
		var adjacent_coordinates = adjacent_coordinates(initial_position, adjancent_building_position)
		var adjacent_building = preload("res://Scenes/AdjacentBuilding.tscn").instance()
		adjacent_building.init(str(i,j,adjancent_building_position), adjacent_coordinates)
		adjacent_building.connect("click",self,"_on_gui_Click")
		add_child(adjacent_building)
			
func adjacent_coordinates(initial_position, adjancent_building_position):
	var initial_adjacent_position = Vector3(0,0,0)
	
	if (adjancent_building_position == "down"):
		initial_adjacent_position = Vector3(
			initial_position.x + 2, 
			initial_position.y, 
			initial_position.z
		)
	elif(adjancent_building_position == "up"):
		initial_adjacent_position = Vector3(
			initial_position.x - 2, 
			initial_position.y, 
			initial_position.z 
		)
	elif(adjancent_building_position == "right"):
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
