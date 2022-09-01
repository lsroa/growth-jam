extends Spatial
export var camera_speed = 4.0
onready var tween = get_node("Camera/Tween")

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT:
			var rotationTransform = Transform2D().rotated(-45)
			var movement = rotationTransform * -event.relative
			self.translate(Vector3(movement.x, 0, movement.y) * (camera_speed / 100))


func move_to_start():
	tween.interpolate_property(self,"translation", self.translation, Vector3(0,0,0), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
