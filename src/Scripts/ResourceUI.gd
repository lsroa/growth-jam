extends Spatial

signal click(id)
var gui
var _id = 0

func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT ):
		print("click")
		emit_signal("click",_id)

func _ready():
	var camera = get_parent().get_node("Pivot/Camera")
	gui = get_node("GUI/Render")
	gui.rotation = camera.rotation

func init(id, _initial_position):
	_id = id
	self.translation = _initial_position
