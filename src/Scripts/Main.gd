extends Spatial
tool

var resources = {} 
var input = {}
#TODO: 
#export(int) var main_building_instance = 9
export(int) var main_building_gap = 8

var score = 0
var resource_types = ["oil", "power", "water", "solar"]

func main_building_coordidate(column, row):
	var resource = preload("res://Scenes/Resource.tscn").instance()
	var initial_position = Vector3(column * main_building_gap, 0, - row * main_building_gap)
	resource.init("(%s,%s)" % [column, row], initial_position, column, row)
	resource.connect("click",self,"_on_gui_Click")
	add_child(resource)

func _ready():
	randomize()
	for column in range(3):
		for row in range(3):
			main_building_coordidate(column, row)
