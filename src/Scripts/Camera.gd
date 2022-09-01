extends Camera
var zoom_factor = 1
var zoom = 15.0


func _input(event):
	if event.is_action("zoom_in"):
		_set_zoom(zoom - zoom_factor)

	if event.is_action("zoom_out"):
		_set_zoom(zoom + zoom_factor)


func _set_zoom(value):
	zoom = clamp(value, 15.0, 30.0)
	self.size = zoom
	
