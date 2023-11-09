## BehavTreeForGroups
## ******************
## Create a new Type of 3D Agent
## into a Type Scene file (.tscn)
## This agent can be added manually
## using the Godot Editor
## or automaticaly (see AddAgent)
## into the main scene.

@icon("Action3D.svg")
@tool

class_name NewAgent3D
extends BehavForGroups

func _ready():
	pass

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
	
	# Set script to rb (if necessary,
	# change rb_script then uncomment below)
	var script = GDScript.new()
	script.set_source_code(rb_script())
	script.reload()
	rb.set_script(script)
	
	# Set parameters
	rb.set_gravity_scale(0)
	rb.contact_monitor = true
	rb.max_contacts_reported = 2
	rb.linear_damp = 5
	rb.angular_damp = 5
	#rb.agent_color = Color(mat.albedo_color)
	
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


func rb_script():
	return """
@tool
extends RigidBody3D

@export var state:int = 0
@export var age:int = 0

func _process(delta):
	if not Engine.is_editor_hint():
		age += 1

func _enter_tree():
	var new_name:String = get_scene_file_path().get_file().trim_suffix(".tscn")
	set_name.call_deferred(new_name)

func emit_changed():
	pass

"""
