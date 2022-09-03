extends Spatial
tool

var time = 0

func _process(delta):
	time += 1 * delta
	self.translation.y = 4.0 + sin(time * 2)/2.5
