extends Spatial
tool

export(int) var main_building_gap = 8
onready var remove_total_building = 5
onready var pivot = get_node("Pivot")

func main_building_coordidate(column, row):
	var resource = preload("res://Scenes/Resource.tscn").instance()
	var initial_position = Vector3(column * main_building_gap, 0, -row * main_building_gap)
	add_child(resource)
	resource.init("%s" % ["ABCDEFGHI"[(column * 3) + row]], initial_position)
		

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		pivot.move_to_menu()
		Game.is_playing = false


func random_positions_to_remove():
	var arr = []

	while len(arr) != remove_total_building:
		var randon_num = int(rand_range(0, 9))
		if not randon_num in arr:
			arr.append(randon_num)

	return arr


func _ready():
	randomize()
	var remove_position_ids = random_positions_to_remove()
	for column in range(3):
		for row in range(3):
			var current_id = (column * 3) + row
			if not current_id in remove_position_ids:
				yield(get_tree().create_timer(1.0), "timeout")
				main_building_coordidate(column, row)
