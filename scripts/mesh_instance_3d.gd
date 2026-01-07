extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material = mesh.surface_get_material(0)
	material.albedo_color = Color.AQUA
	mesh.inner_radius += 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	rotation_degrees += Vector3(0,150,0) * delta
	position += Vector3(1,0,0) * delta
	scale += Vector3(0.5,0.5,0.5) * delta
	
