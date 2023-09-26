extends Generic6DOFJoint3D

var joint_visualisation = MeshInstance3D.new()

var body1 : RigidBody3D
var body2 : RigidBody3D

var init : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	var mesh = CylinderMesh.new()
#	mesh.top_radius = 0.01
#	mesh.bottom_radius = 0.01

	var mesh:SphereMesh = SphereMesh.new()
	mesh.radius = 0.03
	mesh.height = 0.03
	#var mat:Material = joint_visualisation.get_surface_override_material(0)
	#mat.albedo_color = Color(0, 0, 1) 

	joint_visualisation.set_mesh(mesh)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if init == false:
		body1 = get_node(get_node_a()) as PhysicsBody3D
		body2 = get_node(get_node_b()) as PhysicsBody3D
		add_child(joint_visualisation)
		init = true
	
	# verification, bodies are still in the scene
	# If NOT, the Spring is removed
	if body1 == null or body2 == null:
		self.queue_free()
		return
	if body1 and not is_instance_valid(body1):
		body1.lst_cells_linked.erase([body1, body2]);
		body1.lst_cells_linked.erase([body2, body1]);
		self.queue_free()
		return
	if body2 and not is_instance_valid(body2):
		self.queue_free()
		return
		
	draw_mesh_between(body1.global_transform.origin, body2.global_transform.origin)

func draw_mesh_between(a:Vector3, b:Vector3):
	var rnd:float = 0.5 #randf()
	var direction : Vector3 = b - a
	joint_visualisation.global_transform.origin = a + rnd*direction
