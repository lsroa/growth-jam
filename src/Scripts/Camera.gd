extends Camera
var zoom_factor = 1

export var min_zoom = 20.0
export var max_zoom = 30.0
onready var zoom = min_zoom


func _input(event):
	if event.is_action("zoom_in"):
		_set_zoom(zoom - zoom_factor)

	if event.is_action("zoom_out"):
		_set_zoom(zoom + zoom_factor)


func _set_zoom(value):
	zoom = clamp(value, min_zoom, max_zoom)
	self.size = zoom
	
