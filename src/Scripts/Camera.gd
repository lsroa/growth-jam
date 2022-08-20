extends Camera

var zoom := 1.0 setget _set_zoom
var zoom_factor = 1

func _input(event):
	if event.is_action("zoom_in"):
		_set_zoom(zoom - zoom_factor)
		
	if event.is_action("zoom_out"):
		_set_zoom(zoom + zoom_factor)

func _set_zoom(value):
	var tween = get_node("Tween")
	zoom = clamp(value,15.0,30.0)
	tween.interpolate_property(self, "size",
			zoom, zoom, 0.2,
			Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	tween.start()
