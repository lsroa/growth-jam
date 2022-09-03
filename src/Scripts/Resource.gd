extends Spatial
tool

var gui
var _id = 0

export(PackedScene) var adjacent_building
var adjancent_building_positions = ["left", "right", "up", "bottom"]

var dict_adjancent_building_positions = {}

var is_playing_sequence = false
var current_sequence = []
onready var timer = get_node("Timer")
onready var time_label = get_node("Spatial/Viewport/Time")

var current_score_point

#TODO: add player timer when start the game.
# var time = 0


func restart_cooldown():
	var cooldown = randi() % 9 + 3.0
	timer.start(cooldown)
	get_node("Building").init(cooldown)


func _on_adjacent_Click(adjancent_building_position_clicked):
	if not is_playing_sequence:
		validate_player_sequence(adjancent_building_position_clicked)


func _on_Cooldown_timeout():
	current_score_point = len(current_sequence)

	for key in current_sequence:
		yield(get_tree().create_timer(1.0), "timeout")
		dict_adjancent_building_positions[key].sequence_color()


func validate_player_sequence(adjancent_building_position_clicked):
	var current_value_sequence

	if current_sequence:
		current_value_sequence = current_sequence[0]

	if current_value_sequence == adjancent_building_position_clicked:
		current_sequence.pop_front()

		if not current_sequence:
			add_score_point()

	else:
		failed()
		restart_cooldown()


func add_score_point():
	Global.score += current_score_point


func failed():
	for key in dict_adjancent_building_positions.keys():
		dict_adjancent_building_positions[key].failed()


func generate_sequence():
	var max_sequence_number = 5
	var random_len = rand_range(0, max_sequence_number)
	for _i in range(0, random_len):
		var random_index = rand_range(0,dict_adjancent_building_positions.keys().size())
		current_sequence.append(dict_adjancent_building_positions.keys()[random_index])


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


func label_position_gui():
	var label = get_node("Spatial/Viewport/Label")
	label.text = "%s" % [_id]


func init(id, initial_position):
	_id = id
	self.translation = initial_position
	label_position_gui()


func _process(_delta):
	time_label.text = str(stepify(timer.time_left,0.01))
	if not current_sequence:
		generate_sequence()
		restart_cooldown()

func _ready():
	if not Engine.editor_hint:
		var camera = get_parent().get_node("Pivot/Camera")
		gui = get_node("GUI/Render")
		gui.rotation = camera.rotation

	generate_adjacent_buiding()
	generate_sequence()
	restart_cooldown()
