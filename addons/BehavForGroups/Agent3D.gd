@icon("Action.svg")
@tool

class_name Agent3D
extends BehavForGroups


#@export var agent_color:Color :
#	get:
#		return agent_color
#	set(value):
#		color = value
#		get_child(1).material_override.albedo_color = color

func _ready():
	print("Agent3D : _ready")
	# The name is autommatically added
#	if self.is_in_group(group_1) == false:
#		self.add_to_group(group_1)


func _enter_tree():
	var agent_name:String = "Agent"
	print("Agent3D : _enter_tree")
	# Create the rigidBody3D
	var rb:RigidBody3D = RigidBody3D.new()
	rb.name = agent_name
	# Add the collision shape 3D
	var col:CollisionShape3D = CollisionShape3D.new()
	col.name = "CollisionShape3D"
	col.set_shape(SphereShape3D.new())
	rb.add_child(col)
	col.set_owner(rb)
	# New mat
	var mat:StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_color = Color(randf(),randf(),randf())
	# Add the meshinstance 3D
	var msh:MeshInstance3D = MeshInstance3D.new()
	msh.name = "MeshInstance3D"
	msh.set_mesh(SphereMesh.new())
	msh.material_override = mat
	rb.add_child(msh)
	msh.set_owner(rb)
	
	# Set parameters
	rb.add_to_group(agent_name, true)
	print(rb.get_groups())
	rb.set_gravity_scale(0)
	rb.contact_monitor = true
	rb.max_contacts_reported = 2
	
	# Set script to rb
	#var script = GDScript.new()
	#script.set_source_code(rb_script())
	#script.reload()
	#rb.set_script(script)
	
	# Export the new Agent as scene
	print("Agent3D : try to save TSCN")
	var scene = PackedScene.new()
	scene.pack(rb)
	var scene_path:String
	var MAX_AGENT_TSCN = 999999
	# Still a lot (it's .tscn files, NOT instances in scene tree!)
	for i in MAX_AGENT_TSCN:
		scene_path = "res://"+agent_name+str(i)+".tscn"
		# Check if the file already exists
		if ResourceLoader.exists(scene_path)==false:
			break
	# Save the Agent in the resource file .tscn
	ResourceSaver.save(scene, scene_path)
	

	# Free memory resources
	rb.queue_free()	# saved in the .tscn file
	queue_free()	# this node is only made for creating rb
	print("Agent3D : END")


#func _on_resource_renamed(new_name):
#	print("La ressource a été renommée en:" + new_name)
#	

func rb_script():
	return """
@tool
extends RigidBody3D

var _old_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_tree():
	#print("I am entering_tree !!!")
	#remove_from_group(_old_name)
	#print("I remove group:"+_old_name)
	#var type_name = get_scene_file_path().get_file().trim_suffix(".tscn")
	#add_to_group(type_name, true)
	#_old_name = type_name
	#print("I add group:"+type_name)

	#connect("renamed", _on_resource_renamed)
	pass

func emit_changed():
	print("La ressource a été changée")

"""
