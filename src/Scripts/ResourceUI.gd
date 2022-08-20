extends Spatial

signal click(id)
var gui
var id = 0

func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		print("click from area")
		emit_signal("click",id)

func _ready():
	var camera = get_parent().get_node("Camera")
	gui = get_node("GUI/Render")
	gui.rotation = camera.rotation

func init(_id, _initial_position):
	id = _id
	self.translation = _initial_position
