extends Spatial
tool

signal click(id)
var gui
var _id = 0
var fade_material
var building
onready var timer = get_node("Timer")

func _ready():
	building = get_node("Building")
	fade_material = get_node("Fade")
	label_position_gui()


func label_position_gui():
	var label = get_node("Spatial/Viewport/Label")
	label.text = "(%s, %s, %s)" % [self.translation.x, self.translation.y, self.translation.z]


func init(id, _initial_position):
	_id = id
	self.translation = _initial_position


func _on_StaticBody_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_MASK_LEFT and event.pressed:
		flash()
		emit_signal("click", _id)


func flash():
	var material = building.get_active_material(0)
	fade_material.interpolate_property(
		material, "shader_param/level", 1.0, 0.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	fade_material.start()


func _on_Timer_timeout():
	flash()
