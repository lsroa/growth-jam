extends Spatial
export onready var level = -0.5
onready var material = get_node("Area/MeshInstance").get_active_material(0)
var is_on_hold = false
onready var pivot = get_parent().get_node("Pivot")
onready var only_once = true

var is_start = false


func _process(delta):
	if(is_on_hold):
		level = level + 0.05
		material.set_shader_param("level", level)
	if(level >= 1.0 and only_once):
		pivot.move_to_start()
		only_once = false
		is_start = true

	if is_start:
		Global.start_timer(delta)


func _on_Button_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_MASK_LEFT:
		is_on_hold = event.pressed
		Global.restart_timer()

