extends Spatial
tool

var gui
var _id = 0
onready var cooldown = randi() % 9 + 1.0

export(PackedScene) var adjacent_building
var adjancent_building_positions = ["left", "right", "up", "bottom"]

var dict_adjancent_building_positions = {}

var is_playing_sequence = false
var current_sequence = []
onready var timer = get_node("Timer")
onready var time_label = get_node("Spatial/Viewport/Time")

#TODO: pass this variable to a global scope
var score = 0

func _ready():
	if not Engine.editor_hint:
		var camera = get_parent().get_node("Pivot/Camera")
		gui = get_node("GUI/Render")
		gui.rotation = camera.rotation
	label_position_gui()

	generate_adjacent_buiding()
	generate_sequence()
	print("cooldown of %s: %s" % [_id,cooldown])
	timer.start(cooldown)
	get_node("Building").init(cooldown)
	

func _on_adjacent_Click(adjancent_building_position_clicked):
	if not is_playing_sequence:
		validate_player_sequence(adjancent_building_position_clicked)

func _on_Timer_timeout():
	var i = 0.5
	for key in dict_adjancent_building_positions.keys():
		dict_adjancent_building_positions[key].timer.start(i)
		i = i + 1


func validate_player_sequence(adjancent_building_position_clicked):
	var current_value_sequence = current_sequence.pop_front()
	if current_value_sequence == adjancent_building_position_clicked:
		#TODO: add score logic.
		print("player_input: ", current_value_sequence)
		print("current_sequence: ", current_sequence)
	else:
		generate_sequence()


func generate_sequence():
	var max_sequence_number = 5
	var random_len = rand_range(0, max_sequence_number)
	for _i in range(0, random_len):
		var random_index = rand_range(0,dict_adjancent_building_positions.keys().size())
		current_sequence.append(dict_adjancent_building_positions.keys()[random_index])


func label_position_gui():
	var label = get_node("Spatial/Viewport/Label")
	label.text = "%s: (%s, %s, %s)" % [_id, self.translation.x, self.translation.y, self.translation.z]


func generate_adjacent_buiding():
	var random_number = rand_range(0, adjancent_building_positions.size())
	# TODO: This random rule needs to be improved
	var random_adjancent_building_positions = adjancent_building_positions.slice(
		random_number - 1, random_number
	)

	for adjancent_building_position in random_adjancent_building_positions:
		var adjacent_coordinates = adjacent_coordinates(adjancent_building_position)
		var new_adjacent_building = adjacent_building.instance()

		new_adjacent_building.init("%s" % [adjancent_building_position], adjacent_coordinates)
		new_adjacent_building.connect("click", self, "_on_adjacent_Click")
		add_child(new_adjacent_building)
		dict_adjancent_building_positions[adjancent_building_position] = new_adjacent_building


func adjacent_coordinates(adjancent_building_position):
	match adjancent_building_position:
		"bottom":
			return Vector3(self.translation.x + 2, self.translation.y, self.translation.z)
		"up":
			return Vector3(self.translation.x - 2, self.translation.y, self.translation.z)
		"right":
			return Vector3(self.translation.x - 0.5, self.translation.y, self.translation.z - 2)
		"left":
			return Vector3(self.translation.x, self.translation.y, self.translation.z + 2)


func init(id, initial_position):
	_id = id
	self.translation = initial_position


func _on_Area_input_event(_camera, _event, _position, _normal, _shaperowx):
	pass
	# emit_signal("click",_id)
	
func _process(_delta):
	time_label.text = str(stepify(timer.time_left,0.01))
