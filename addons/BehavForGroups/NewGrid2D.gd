@icon("Action.svg")
@tool

class_name NewGrid2D
extends BehavForGroups

func _ready():
	pass

func _enter_tree():
	var agent_name:String = "Grid2D"
	print("Grid2D : _enter_tree")
	# Create the rigidBody3D
	var tr:TextureRect = TextureRect.new()
	tr.name = agent_name
	# Add the Image
	var SX:int = 64
	var SY:int = 32	
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	for x in range(SX):
		for y in range(SY):
			img.set_pixel(x,y, Color(randf(),randf(),randf(),randf()))
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
	tr.queue_free()	# saved in the .tscn file
	queue_free()	# this node is only made for creating tr
	print("Grid2D : END")

func tr_script():
	return """
@tool
extends TextureRect
class_name Grid2D

@export var baseColor:Color = Color(0.5,0.5,0.5,0.5)
@export var diffusionRate = 0.3
@export var degradationRate = 0.001

@export var state:int = 0
@export var age:int = 0
var values_t0:PackedFloat32Array = PackedFloat32Array()
var values_t1:PackedFloat32Array = PackedFloat32Array()
var SX:int = 64
var SY:int = 32

func _ready():
	values_t0.resize(SX*SY)
	values_t1.resize(SX*SY)
	for i in range(SX*SY):
		values_t0[i] = randf()

func _process(delta):
	if not Engine.is_editor_hint():
		diffusion()
		display_values()
		age += 1
		
func _enter_tree():
	var new_name:String = get_scene_file_path().get_file().trim_suffix(".tscn")
	set_name.call_deferred(new_name)

func diffusion():
	for i in range(SX):
		for j in range(SY):
			var p:int = i+j*SX
			var v0:float = values_t0[ (i+1)%SX+j*SX]
			var v1:float = values_t0[ (i-1+SX)%SX+j*SX]
			var v2:float = values_t0[ i%SX+((j+1)%SY)*SX]
			var v3:float = values_t0[ i%SX+((j-1+SY)%SY)*SX]
			values_t1[p] = (1.0-degradationRate)*(1.0-diffusionRate)*values_t0[p] + diffusionRate*(v0+v1+v2+v3)*0.25
	
	for i in range(SX*SY):
		values_t0[i] = values_t1[i]

func display_values():
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	for i in range(SX):
		for j in range(SY):
			var p:int = i+j*SX
			var v:float = values_t0[p]
			img.set_pixel(i,j,Color(v*baseColor.r,v*baseColor.g,v*baseColor.b,baseColor.a) )
	set_texture(ImageTexture.create_from_image(img))

		
"""
