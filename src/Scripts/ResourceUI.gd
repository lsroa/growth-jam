extends Spatial
signal click(event)

func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		emit_signal("click",event)

func _ready():
	var camera = get_parent().get_node("Camera")
	var gui = get_node("GUI")
	gui.rotation = camera.rotation

	
