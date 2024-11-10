## Create a new Type of 2D Agent
## into a Type Scene file (.tscn)
## This agent can be added manually
## using the Godot Editor
## or automaticaly (see AddAgent)
## into the main scene.

@icon("action_2d.svg")
@tool

class_name NewAgent2D
extends BehaviorTreeForGroups

func _ready():
	pass


# Définition de la classe PromptDialog
class PromptDialog extends Window:
	var input_field: LineEdit
	signal prompt_confirmed(input_text: String)

	func _ready() -> void:
		# Créer un conteneur vertical
		var vbox:VBoxContainer = VBoxContainer.new()

		# Créer un champ LineEdit pour saisir le texte
		input_field = LineEdit.new()
		vbox.add_child(input_field)
		input_field.expand_to_text_length = true

		# Créer un bouton OK
		var ok_button = Button.new()
		ok_button.text = "OK"
		ok_button.pressed.connect(self._on_ok_button_pressed)
		vbox.add_child(ok_button)

		# Ajouter le conteneur à la fenêtre
		add_child(vbox)


	func _on_ok_button_pressed() -> void:
		emit_signal("prompt_confirmed", input_field.text)
		hide()
		print("PromptDialog : _on_ok_button_pressed")


# Scène principale qui hérite de Node2D
var prompt_instance: PromptDialog
func _on_prompt_confirmed(input_text: String) -> void:
	print("L'utilisateur a saisi : ", input_text)

func _enter_tree():
	print("Agent2D : _enter_tree")
	# Create the rigidBody3D
	var rb:RigidBody2D = RigidBody2D.new()








	# Création du PromptDialog manuellement
	prompt_instance = PromptDialog.new()

	# Ajout de la scène du prompt comme enfant
	#add_child(prompt_instance)
	#get_editor_interface().get_base_control().add_child(prompt_instance)
	var editor_root = get_tree().root.get_child(0)  # Accède à la fenêtre principale de l'éditeur
	editor_root.add_child(prompt_instance)

	prompt_instance.min_size = Vector2i(640, 150) 
	prompt_instance.reset_size()
	prompt_instance.move_to_center()
	prompt_instance.title = "Name the new 2d agent"

	# Rendre la fenêtre modale pour bloquer les interactions avec l'interface principale
	prompt_instance.set_transient(true)
	prompt_instance.set_exclusive(true)


	# Connexion du signal de confirmation
	prompt_instance.prompt_confirmed.connect(_on_prompt_confirmed)




	# Attendre que l'utilisateur confirme la fenêtre (bloque l'exécution ici)
	# Open the name window and apply the name to the new agent 2d
	var result = await prompt_instance.prompt_confirmed

	var agent_name:String = result #prompt_instance.choosen_name #"agent_2d_"

	if agent_name.is_valid_filename() == false:
		print("Agent2D : invalid agent name => agent NOT created. Use a valid filename.")
		return

	rb.name = agent_name
	rb.add_to_group(agent_name, true)
	
	
	
	
	
	
	# Add the collision shape 3D
	var col:CollisionShape2D = CollisionShape2D.new()
	col.name = "CollisionShape2D"
	var cs:CircleShape2D = CircleShape2D.new()
	cs.radius = 10
	col.set_shape(cs)
	rb.add_child(col)
	col.set_owner(rb)
	# Add the Polygon2D
	var poly:Polygon2D = Polygon2D.new()
	poly.name = "Polygon2D"
	var vertices:PackedVector2Array = PackedVector2Array(polygone2D_regular(10,6))

	# Attribuer les sommets au Polygon2D
	poly.set_polygon(vertices)
	#msh.scale = Vector2(20,20)
	#msh.set_mesh(SphereMesh.new())
	#msh.material = mat
	rb.add_child(poly)
	poly.set_owner(rb)

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
	#for i in MAX_AGENT_TSCN:
	scene_path = "res://"+agent_name+".tscn" #"res://"+agent_name+str(i)+".tscn"
	# Check if the file already exists
	if ResourceLoader.exists(scene_path)==true:
		print("new Agent2D:agent already exists. Try a new name or remove the agent")
		return
	# Save the Agent in the resource file .tscn
	ResourceSaver.save(scene, scene_path)

	# Free memory resources
	rb.queue_free() # saved in the .tscn file
	queue_free() # this node is only made for creating rb
	print("Agent2D : END")

func polygone2D_regular(radius:float, n:int) -> PackedVector2Array:
	var arr_poly:PackedVector2Array = PackedVector2Array()
	for a in range(0,n):
		var x:float = radius * cos(deg_to_rad(a*360.0 / n))
		var y:float = radius * sin(deg_to_rad(a*360.0 / n))
		arr_poly.append(Vector2(x,y))
	return arr_poly

func rb_script():
	return """
@tool
extends RigidBody2D

@export var state:int = 0
@export var age:int = 0

func _process(_delta):
	if not Engine.is_editor_hint():
		age += 1

"""
