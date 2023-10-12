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
	var agent_name:String = "toto"
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
	
	
	# Configure the Agent with a Window
	#var editor = EditorInterface.get_singleton().get_editor_window()
	
	var panel = Panel.new()
	add_child(panel)
	panel.position = Vector2(100, 100)  # Set position (adjust as needed)
	panel.size = Vector2(400, 300)  # Set size (adjust as needed)

	# Create label
	var label = Label.new()
	label.text = "Configuration Window"
	panel.add_child(label)

	# Create input field
	var input = LineEdit.new()
	panel.add_child(input)

	# Create button
	var button = Button.new()
	button.text = "Save"
	panel.add_child(button)
	button.connect("pressed",_on_save_button_pressed)

	# Set positions of elements (adjust as needed)
	label.position = Vector2(50, 50)
	input.position = Vector2(50, 100)
	button.position = Vector2(50, 150)
	
	# Export the new Agent as scene
	print("Agent3D : try to save TSCN")
	var scene = PackedScene.new()
	scene.pack(rb)
	var scene_path:String = "res://"+agent_name+".tscn"
	ResourceSaver.save(scene, scene_path)
	rb.queue_free()
	#queue_free()
	print("Agent3D : END")



func _on_save_button_pressed():
	# Handle save button press
	var input_text = get_node("LineEdit").text
	print("Saved input:", input_text)
	# Apply configuration changes here
	queue_free()  # Close the configuration window






