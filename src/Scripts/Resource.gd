extends Spatial
tool

signal click(id)
var gui
var _id = 0
var _column
var _row
var _initial_position

var adjancent_building_positions = ["left", "right", "up", "bottom"]

enum sequence_status {active, finish}
var current_sequence = ["left","left","left","right"]
var player_sequence = "left"

#TODO: pass this variable to a global scope
var score = 0


func _on_gui_Click(adjancent_building_position):
	score+=1
	var current_value_sequence = current_sequence.pop_front()
	if current_value_sequence == adjancent_building_position:
		print("player_sequence: " , current_value_sequence)
		print("player_sequence: " , current_sequence)

func validate_player_sequence():
	pass

func _ready():
	if not Engine.editor_hint:
		var camera = get_parent().get_node("Pivot/Camera")
		gui = get_node("GUI/Render")
		gui.rotation = camera.rotation
	assign_adjacent_buiding(_initial_position)


func assign_adjacent_buiding(initial_position):
	var random_number = rand_range(0, adjancent_building_positions.size())
	# TODO: This random rule needs to be improved
	var random_adjancent_building_positions = adjancent_building_positions.slice(random_number - 1, random_number)

	for adjancent_building_position in random_adjancent_building_positions:
		var adjacent_coordinates = adjacent_coordinates(initial_position, adjancent_building_position)
		var adjacent_building = preload("res://Scenes/AdjacentBuilding.tscn").instance()
		adjacent_building.init("%s" % [adjancent_building_position], adjacent_coordinates)
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

func init(id, initial_position, column, row):
	_id = id
	_column = column
	_row = row
	_initial_position = initial_position
	self.translation = initial_position

func _on_Area_input_event(_camera, _event, _position, _normal, _shaperowx):
	pass 
	# emit_signal("click",_id)
	

