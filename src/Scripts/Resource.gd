extends Spatial
tool

var gui
var _id = 0

export (PackedScene) var adjacent_building
var adjancent_building_positions = ["left", "right", "up", "bottom"]

enum sequence_status {active, finish}
var current_sequence = ["left","left","left","right"]
var player_sequence = "left"

#TODO: pass this variable to a global scope
var score = 0


func _on_gui_Click(adjancent_building_position):
#	score+=1
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
	var label = get_node("Spatial/Viewport/Label")
	label.text = "(%s, %s, %s)" % [self.translation.x, self.translation.y, self.translation.z]
	assign_adjacent_buiding()


func assign_adjacent_buiding():
	var random_number = rand_range(0, adjancent_building_positions.size())
	# TODO: This random rule needs to be improved
	var random_adjancent_building_positions = adjancent_building_positions.slice(random_number - 1, random_number)

	for adjancent_building_position in random_adjancent_building_positions:
		var adjacent_coordinates = adjacent_coordinates(adjancent_building_position)
		var new_adjacent_building = adjacent_building.instance()

		new_adjacent_building.init("%s" % [adjancent_building_position], adjacent_coordinates)
		new_adjacent_building.connect("click", self, "_on_gui_Click")
		add_child(new_adjacent_building)

func adjacent_coordinates(adjancent_building_position):

	match (adjancent_building_position):
		"bottom":
			return Vector3(
				self.translation.x + 2,
				self.translation.y,
				self.translation.z
			)
		"up":
			return Vector3(
				self.translation.x - 2,
				self.translation.y,
				self.translation.z
			)
		"right":
			return Vector3(
				self.translation.x - 0.5,
				self.translation.y,
				self.translation.z - 2
			)
		"left":
			return Vector3(
				self.translation.x,
				self.translation.y,
				self.translation.z + 2
			)


func init(id, initial_position):
	_id = id
	self.translation = initial_position

func _on_Area_input_event(_camera, _event, _position, _normal, _shaperowx):
	pass
	# emit_signal("click",_id)


