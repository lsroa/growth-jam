extends MeshInstance
tool

export(Array, Mesh) var mesh_pools
export(Shader) var shader
onready var load_material = get_node("Tween")
export(Array, Color) var colors
onready var material = ShaderMaterial.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.mesh = mesh_pools[randi() % 4].duplicate()
	self.mesh.surface_set_material(0,material)
	self.translation.y = 1
	material.set_shader_param("LOAD_COLOR", colors[randi() % colors.size()])
	material.shader = shader


func init(cooldown):
	load_material.interpolate_property(
		material, "shader_param/level", -1, 1.01, cooldown, Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	load_material.start()

