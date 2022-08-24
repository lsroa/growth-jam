extends MeshInstance
tool 

export(Array, Mesh) var mesh_pools
export(Shader) var shader

# Called when the node enters the scene tree for the first time.
func _ready():
	self.mesh = mesh_pools[randi() % 4]
	self.mesh.surface_set_material(0, ShaderMaterial.new())
	self.translation.y = 1
	_assign_shader_to_material(mesh)

func _assign_shader_to_material(mesh: Mesh):
	for m in mesh.get_surface_count():
		var material = mesh.surface_get_material(m)
		material.set_shader_param("LOAD_COLOR", Color(0,1,0)) 
		material.shader = shader
		
