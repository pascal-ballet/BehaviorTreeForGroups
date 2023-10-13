@icon("Action.svg")
@tool

class_name Agent2D
extends BehavForGroups

func _ready():
	pass

func _enter_tree():
	var agent_name:String = "Agent"
	print("Agent2D : _enter_tree")
	# Create the rigidBody3D
	var rb:RigidBody2D = RigidBody2D.new()
	rb.name = agent_name
	# Add the collision shape 3D
	var col:CollisionShape2D = CollisionShape2D.new()
	col.name = "CollisionShape2D"
	var cs:CircleShape2D = CircleShape2D.new()
	cs.radius = 10
	col.set_shape(cs)
	rb.add_child(col)
	col.set_owner(rb)
	# New mat
	var mat:CanvasItemMaterial = CanvasItemMaterial.new()
	#mat.blend_mode = CanvasItemMaterial.BLEND_MODE_MUL
	#mat. .albedo_color = Color(randf(),randf(),randf())
	# Add the meshinstance 3D
	var msh:MeshInstance2D = MeshInstance2D.new()
	msh.name = "MeshInstance2D"
	msh.scale = Vector2(20,20)
	msh.set_mesh(SphereMesh.new())
	msh.material = mat
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
	rb.linear_damp = 1
	rb.angular_damp = 1
	#rb.agent_color = Color(mat.albedo_color)
	
	# Export the new Agent as scene
	print("Agent2D : try to save TSCN")
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
	print("Agent2D : END")


func rb_script():
	return """
@tool
extends RigidBody2D

#@export var agent_color:Color :
#	get:
#		return agent_color
#	set(value):
#		agent_color = value
#		if get_child(1) != null:
#			get_child(1).material_override.albedo_color = agent_color

func _ready():
	pass

func _process(delta):
	pass

func _enter_tree():
	var new_name:String = get_scene_file_path().get_file().trim_suffix(".tscn")
	set_name.call_deferred(new_name)

func emit_changed():
	pass

"""
