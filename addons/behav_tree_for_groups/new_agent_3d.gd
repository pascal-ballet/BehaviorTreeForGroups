## Create a new Type of 3D Agent
## into a Type Scene file (.tscn)
## This agent can be added manually
## using the Godot Editor
## or automaticaly (see AddAgent)
## into the main scene.

@icon("action_3d.svg")
@tool

class_name NewAgent3D
extends BehaviorTreeForGroups

signal prompt_confirmed(input_text: String)
signal prompt_canceled
# Scène principale qui hérite de Node2D
var prompt_instance: PromptDialog

func _on_prompt_confirmed(input_text: String) -> void:
	print("L'utilisateur a validé la saisie : ", input_text)
	
func _on_prompt_canceled(input_text: String) -> void:
	print("L'utilisateur a annulé la saisie : ", input_text)
	queue_free()
	
func _enter_tree():
	print("Agent3D : _enter_tree")

	# Creation of the PromptDialog
	prompt_instance = PromptDialog.new()

	print("Agent3D : prompt_instance created")

	# Ajout de la scène du prompt comme enfant
	#add_child(prompt_instance)
	#get_editor_interface().get_base_control().add_child(prompt_instance)
	var editor_root = get_tree().root.get_child(0)  # Accède à la fenêtre principale de l'éditeur
	editor_root.add_child(prompt_instance)

	prompt_instance.min_size = Vector2i(320, 80)
	prompt_instance.reset_size()
	prompt_instance.move_to_center()
	prompt_instance.title = "Name the new 3d agent"

	# Rendre la fenêtre modale pour bloquer les interactions avec l'interface principale
	prompt_instance.set_transient(true)
	prompt_instance.set_exclusive(true)


	prompt_instance.close_requested.connect(func():
		prompt_instance._on_cancel_button_pressed()
	)

	# Connexion du signal de confirmation
	prompt_instance.prompt_confirmed.connect(_on_prompt_confirmed)
	# Connexion du signal d'annulation
	prompt_instance.prompt_canceled.connect(_on_prompt_canceled)

	# Attendre que l'utilisateur confirme la fenêtre (bloque l'exécution ici)
	# Open the name window and apply the name to the new agent 2d
	var result = await prompt_instance.prompt_confirmed

	# The new agent is a .tscn file
	# It must have a valid filename
	var agent_name:String = result
	if agent_name.is_valid_filename() == false:
		print("Agent3D : invalid agent name => agent NOT created. Use a valid filename.")
		free_my_resources(null)
		return

	build_agent_3d(agent_name)

func free_my_resources(rb:RigidBody3D):
	# Free memory resources
	if rb != null:
		rb.queue_free() # saved in the .tscn file
	self.queue_free() # this node is only made for creating rb
	print("Agent3D : Removed from Scene Tree")

func build_agent_3d(agent_name:String):
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
	# Still a lot (it's .tscn files, NOT instances in scene tree!)
	scene_path = "res://"+agent_name+".tscn"
	# Check if the file already exists
	if ResourceLoader.exists(scene_path)==true:
		print("new Agent2D:agent already exists. Try a new name or remove the agent")
		free_my_resources(rb)
		return
	# Save the Agent in the resource file .tscn
	ResourceSaver.save(scene, scene_path)
	free_my_resources(rb)

	print("Agent3D : END")


func rb_script():
	return """
@tool
extends RigidBody3D

@export var state:int = 0
@export var age:int = 0

func _process(_delta):
	if not Engine.is_editor_hint():
		age += 1

func emit_changed():
	pass

"""
