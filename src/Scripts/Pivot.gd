extends Spatial
export var camera_speed = 4.0
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT:
			var rotationTransform = Transform2D().rotated(-45)
			var movement =   rotationTransform * -event.relative
			self.translate(Vector3(movement.x, 0, movement.y) * (camera_speed/100))
