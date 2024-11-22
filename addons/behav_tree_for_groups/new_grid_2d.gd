## Create a new Type of 2D Grid
## into a Type Scene file (.tscn)
## This grid can be added manually
## using the Godot Editor
## or automaticaly (see AddAgent)
## into the main scene.

@icon("action_2d.svg")
@tool

class_name NewGrid2D
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
	print("Grid2D : _enter_tree")

	# Creation of the PromptDialog
	prompt_instance = PromptDialog.new()

	print("Grid2D : prompt_instance created")

	# Ajout de la scène du prompt comme enfant
	#add_child(prompt_instance)
	#get_editor_interface().get_base_control().add_child(prompt_instance)
	var editor_root = get_tree().root.get_child(0)  # Accède à la fenêtre principale de l'éditeur
	editor_root.add_child(prompt_instance)

	prompt_instance.min_size = Vector2i(320, 80)
	prompt_instance.reset_size()
	prompt_instance.move_to_center()
	prompt_instance.title = "Name the new 2d grid"

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
		print("Grid2D : invalid agent name => agent NOT created. Use a valid filename.")
		free_my_resources(null)
		return

	build_grid_2d(agent_name)

func free_my_resources(tr:TextureRect):
	# Free memory resources
	if tr != null:
		tr.queue_free() # saved in the .tscn file
	self.queue_free() # this node is only made for creating rb
	print("Grid2D : Removed from Scene Tree")

func build_grid_2d(agent_name:String):
	# Create the rigidBody3D
	var tr:TextureRect = TextureRect.new()
	tr.name = agent_name
	tr.add_to_group(agent_name, true)

	# Add the Image
	var SX:int = 64
	var SY:int = 32	
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	for x in range(SX):
		for y in range(SY):
			var rnd:float = 0#randf()
			if x == 0 || x == SX-1 || y == 0 || y == SY-1:
				img.set_pixel(x,y, Color(rnd,rnd,rnd,1))
	# Put the image into a texture for rendering
	tr.set_texture(ImageTexture.create_from_image(img))
	
	# Set script to tr
	var script = GDScript.new()
	script.set_source_code(tr_script())
	script.reload()
	tr.set_script(script)
	
	# Export the new Agent as scene
	print("Grid2D : try to save TSCN")
	var scene = PackedScene.new()
	scene.pack(tr)
	var scene_path:String
	# Still a lot (it's .tscn files, NOT instances in scene tree!)
	scene_path = "res://"+agent_name+".tscn"
	# Check if the file already exists
	if ResourceLoader.exists(scene_path)==true:
		print("new Grid2D:agent already exists. Try a new name or remove the agent")
		free_my_resources(tr)
		return
	# Save the Agent in the resource file .tscn
	ResourceSaver.save(scene, scene_path)
	free_my_resources(tr)

	print("Grid2D : END")

func tr_script() -> String:
	var scp:Script = load("res://addons/behav_tree_for_groups/grid2d.gd")
	return scp.source_code
	#return """
#@tool
#extends TextureRect
#class_name Grid2D
#
#@export var baseColor:Color = Color(0.5,0.5,0.5,0.5)
#@export var diffusionRate = 0.3
#@export var degradationRate = 0.001
#@export var display_value:bool = false
#@export var show_iso:bool = false
#
#@export var SX:int = 64
#@export var SY:int = 32
#@export var loop_x:bool = false
#@export var loop_y:bool = false
#
#@export var state:int = 0
#@export var age:int = 0
#
#var values_t0:PackedFloat32Array = PackedFloat32Array()
#var values_t1:PackedFloat32Array = PackedFloat32Array()
#
#var xmin:float; var xmax:float; var ymin:float;var ymax:float
#
#func _ready():
	#values_t0.resize(SX*SY)
	#values_t1.resize(SX*SY)
	#for i in range(SX*SY):
		#values_t0[i] = 0
#
	#if loop_x == true:
		#xmin = 0
		#xmax = SX
	#else:
		#xmin = 1
		#xmax = SX-1
#
	#if loop_y == true:
		#ymin = 0
		#ymax = SY
	#else:
		#ymin = 1
		#ymax = SY-1
		#
#
#func _process(_delta):
	#if not Engine.is_editor_hint():
		#diffusion()
		#if show_iso == false:
			#display_values()
		#else:
			#display_iso()
		#if display_value == true:
			#print_value()
		#age += 1
#
#func diffusion():
	#for i in range(xmin,xmax):
		#for j in range(ymin,ymax):
			#var p:int = i+j*SX
			#var v0:float = values_t0[ (i+1)%SX+j*SX]
			#var v1:float = values_t0[ (i-1+SX)%SX+j*SX]
			#var v2:float = values_t0[ i%SX+((j+1)%SY)*SX]
			#var v3:float = values_t0[ i%SX+((j-1+SY)%SY)*SX]
			#values_t1[p] = (1.0-degradationRate)*(1.0-diffusionRate)*values_t0[p] + diffusionRate*(v0+v1+v2+v3)*0.25
	#
	#for i in range(SX*SY):
		#values_t0[i] = values_t1[i]
#
#func display_values():
	#var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	#for i in range(SX):
		#for j in range(SY):
			#var p:int = i+j*SX
			#var v:float = values_t0[p]
			#img.set_pixel(i,j,Color(v*baseColor.r,v*baseColor.g,v*baseColor.b,baseColor.a) )
	#set_texture(ImageTexture.create_from_image(img))
	#
#func print_value():
	#var i:int   = randi_range(0, SX-1)
	#var j:int   = randi_range(0, SY-1)
	#var v:float = values_t0[i+j*SX]
	#print("At (" + str(i) + "," + str(j) + ")=" + str(num_zeros(v)) + "<=" + str(v) )
#
#func num_zeros(val:float) -> int:
	#var n:int = 0
	#if val != 0:
		#n = -floor(   log(abs(val)) / log(10)  ) - 1
	#return n
#
#func display_iso():
	#var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	#var r:float; var g:float; var b:float
	#for i in range(1,SX-2):
		#for j in range(1,SY-2):
			#var p:int = i+j*SX
			#var v0:float = num_zeros(values_t0[p])
			#var vg:float = num_zeros(values_t0[p-1])
			#var vd:float = num_zeros(values_t0[p+1])
			#var vh:float = num_zeros(values_t0[p-SX])
			#var vb:float = num_zeros(values_t0[p+SX])
			#var e:float = 1.0
			#if vg>v0 || vd>v0 || vh>v0 || vb>v0:
				#e = 0.5
			#img.set_pixel(i,j,Color(e*baseColor.r,e*baseColor.g,e*baseColor.b,baseColor.a) )
	#set_texture(ImageTexture.create_from_image(img))
#
#"""
