extends Spatial

signal click(id)
var gui
var _id = 0
var _type = ""

func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT ):
		emit_signal("click",_id,_type)

func _ready():
	var camera = get_parent().get_node("Camera")
	gui = get_node("GUI/Render")
	gui.rotation = camera.rotation

func init(id, _initial_position,type):
	_id = id
	_type = type
	self.translation = _initial_position
