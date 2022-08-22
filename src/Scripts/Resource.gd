extends Spatial

signal click(id)
var gui
var _id = 0


func _ready():
	var camera = get_parent().get_node("Pivot/Camera")
	gui = get_node("GUI/Render")
	gui.rotation = camera.rotation
	

func init(id, _initial_position):
	_id = id
	self.translation = _initial_position

func _on_Area_input_event(_camera, _event, _position, _normal, _shape_idx):
	emit_signal("click",_id)


