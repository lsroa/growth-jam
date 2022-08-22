extends Spatial
var resources = {} 
var input = {}
#TODO: 
#export(int) var main_building_instance = 9
export(int) var main_building_gap = 8

var score = 0
var resource_types = ["oil", "power", "water", "solar"]
var adjancent_building_positions = ["left", "right", "up", "bottom"]

func _on_gui_Click(id):
	print("id: " , id)
	score+=1
	print("score: " , score)
#	input[type].append(id)
	print(input)

func main_building_coordidate(column, row):
	var resource = preload("res://Scenes/Resource.tscn").instance()
	var initial_position = Vector3(column * main_building_gap, 0, - row * main_building_gap)
	resource.init("(%s,%s)" % [column, row],initial_position)
	resource.connect("click",self,"_on_gui_Click")
	add_child(resource)
	assign_adjacent_buiding(column, row, initial_position)
	
func assign_adjacent_buiding(column, row, initial_position):
	var random_number = rand_range(0, adjancent_building_positions.size())
	# TODO: This random rule needs to be improved
	var random_adjancent_building_positions = adjancent_building_positions.slice(random_number - 1, random_number)

	for adjancent_building_position in random_adjancent_building_positions:
		var adjacent_coordinates = adjacent_coordinates(initial_position, adjancent_building_position)
		var adjacent_building = preload("res://Scenes/AdjacentBuilding.tscn").instance()
		adjacent_building.init("(%s,%s):%s" % [column, row,adjancent_building_position], adjacent_coordinates)
		adjacent_building.connect("click",self,"_on_gui_Click")
		add_child(adjacent_building)

func adjacent_coordinates(initial_position, adjancent_building_position):
	var initial_adjacent_position = Vector3(0,0,0)
	
	match (adjancent_building_position):
		"bottom":
			initial_adjacent_position = Vector3(
				initial_position.x + 2, 
				initial_position.y, 
				initial_position.z
			)
		"up":
			initial_adjacent_position = Vector3(
				initial_position.x - 2, 
				initial_position.y, 
				initial_position.z 
			)
		"right":
			initial_adjacent_position = Vector3(
				initial_position.x - 0.5, 
				initial_position.y, 
				initial_position.z - 2
			)
		"left":
			initial_adjacent_position = Vector3(
				initial_position.x, 
				initial_position.y, 
				initial_position.z + 2
			)

	return initial_adjacent_position
 
func _ready():
	for column in range(3):
		for row in range(3):
			main_building_coordidate(column, row)
