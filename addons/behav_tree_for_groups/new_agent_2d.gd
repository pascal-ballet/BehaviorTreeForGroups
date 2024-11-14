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
	signal prompt_canceled

	func _ready() -> void:
		# Créer un conteneur vertical
		var vbox:VBoxContainer = VBoxContainer.new()
		vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
		# Set light grey background color
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.9, 0.0, 0.9, 1.0)  # Light grey color
		vbox.add_theme_stylebox_override("panel", style)
		# Add a MarginContainer for better spacing
		var margin = MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 16)
		margin.add_theme_constant_override("margin_right", 16)
		vbox.add_child(margin)
		
		
		
		
		# Créer un champ LineEdit pour saisir le texte
		input_field = LineEdit.new()
		input_field.alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
		input_field.expand_to_text_length = true
		input_field.placeholder_text = "agent_name"
		vbox.add_child(input_field)

		# Creer une HBox pour les Button
		var hbox:HBoxContainer = HBoxContainer.new()
		hbox.set_anchors_preset(Control.PRESET_FULL_RECT)
		hbox.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		hbox.add_theme_constant_override("separation", 10)  # Space between buttons
		
		vbox.add_child(hbox)

		# Créer un bouton OK
		var ok_button = Button.new()
		ok_button.text = "OK"
		ok_button.pressed.connect(self._on_ok_button_pressed)
		ok_button.size_flags_horizontal = Control.SIZE_FILL
		set_button_style(ok_button, Color(0.0, 0.6, 0.0, 1.0))
		hbox.add_child(ok_button)

		# Créer un bouton CANCEL
		var cancel_button = Button.new()
		cancel_button.text = "CANCEL"
		cancel_button.pressed.connect(self._on_cancel_button_pressed)
		set_button_style(cancel_button, Color(0.6, 0.0, 0.0, 1.0))
		hbox.add_child(cancel_button)


		# Ajouter le conteneur à la fenêtre
		add_child(vbox)


	func _on_ok_button_pressed() -> void:
		emit_signal("prompt_confirmed", input_field.text)
		hide()
		print("PromptDialog : _on_ok_button_pressed")
		
	func _on_cancel_button_pressed() -> void:
		emit_signal("prompt_canceled", "")
		hide()
		print("PromptDialog : _on_cancel_button_pressed")

	func set_button_style(button:Button, text_color:Color):
		# Create button styles
		var normal_style = StyleBoxFlat.new()
		normal_style.bg_color = Color(0.6, 0.6, 0.6, 1.0)
		normal_style.corner_radius_top_left = 4
		normal_style.corner_radius_top_right = 4
		normal_style.corner_radius_bottom_left = 4
		normal_style.corner_radius_bottom_right = 4
	
		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color(0.8, 0.8, 0.8, 1.0)
		hover_style.corner_radius_top_left = 4
		hover_style.corner_radius_top_right = 4
		hover_style.corner_radius_bottom_left = 4
		hover_style.corner_radius_bottom_right = 4
	
		var pressed_style = StyleBoxFlat.new()
		pressed_style.bg_color = Color(0.85, 0.85, 0.85, 1.0)
		pressed_style.corner_radius_top_left = 4
		pressed_style.corner_radius_top_right = 4
		pressed_style.corner_radius_bottom_left = 4
		pressed_style.corner_radius_bottom_right = 4
		
		# Apply styles to button
		button.add_theme_stylebox_override("normal", normal_style)
		button.add_theme_stylebox_override("hover", hover_style)
		button.add_theme_stylebox_override("pressed", pressed_style)
		
		# Add padding to button
		button.custom_minimum_size.x = 100
		button.custom_minimum_size.y = 30
		
		# Set button text color
		button.add_theme_color_override("font_color", Color.WHITE)
		button.add_theme_color_override("font_hover_color", text_color)



# Scène principale qui hérite de Node2D
var prompt_instance: PromptDialog

func _on_prompt_confirmed(input_text: String) -> void:
	print("L'utilisateur a validé la saisie : ", input_text)
	
func _on_prompt_canceled(input_text: String) -> void:
	print("L'utilisateur a annulé la saisie : ", input_text)
	queue_free()
	

func _enter_tree():
	print("Agent2D : _enter_tree")







	# Création du PromptDialog manuellement
	prompt_instance = PromptDialog.new()

	print("Agent2D : prompt_instance created")

	# Ajout de la scène du prompt comme enfant
	#add_child(prompt_instance)
	#get_editor_interface().get_base_control().add_child(prompt_instance)
	var editor_root = get_tree().root.get_child(0)  # Accède à la fenêtre principale de l'éditeur
	editor_root.add_child(prompt_instance)

	prompt_instance.min_size = Vector2i(320, 80)
	prompt_instance.reset_size()
	prompt_instance.move_to_center()
	prompt_instance.title = "Name the new 2d agent"

	# Rendre la fenêtre modale pour bloquer les interactions avec l'interface principale
	prompt_instance.set_transient(true)
	prompt_instance.set_exclusive(true)


	prompt_instance.close_requested.connect(func():
		prompt_instance._on_cancel_button_pressed()
		#emit_signal("prompt_canceled", "")
		#queue_free()
	)


	#prompt_instance.input_field.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	#prompt_instance.input_field.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#prompt_instance.input_field.size = Vector2i(640, 50) 


	print("Agent2D : before cnx")
	# Connexion du signal de confirmation
	prompt_instance.prompt_confirmed.connect(_on_prompt_confirmed)
	# Connexion du signal d'annulation
	prompt_instance.prompt_canceled.connect(_on_prompt_canceled)
	print("Agent2D : after cnx")


	# Attendre que l'utilisateur confirme la fenêtre (bloque l'exécution ici)
	# Open the name window and apply the name to the new agent 2d
	var result = await prompt_instance.prompt_confirmed

	var agent_name:String = result

	if agent_name.is_valid_filename() == false:
		print("Agent2D : invalid agent name => agent NOT created. Use a valid filename.")
		free_my_resources(null)
		return

	# Create the rigidBody3D
	print("Agent2D : creation of RigidBody2D")
	var rb:RigidBody2D = RigidBody2D.new()

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
	free_my_resources(rb)

func free_my_resources(rb:RigidBody2D):
	# Free memory resources
	if rb != null:
		rb.queue_free() # saved in the .tscn file
	self.queue_free() # this node is only made for creating rb
	print("Agent2D : Removed from Scene Tree")

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
