extends Spatial
tool

export(int) var main_building_gap = 8
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
		

func _ready():
	randomize()
	for column in range(3):
		for row in range(3):
			if randf() > 0.5: 
				main_building_coordidate(column, row)
