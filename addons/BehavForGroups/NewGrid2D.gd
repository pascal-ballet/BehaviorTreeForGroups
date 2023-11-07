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
@export var show_iso:bool = false
@export var diffusionRate = 0.3
@export var degradationRate = 0.001

@export var SX:int = 64
@export var SY:int = 32
@export var loop_x:bool = false
@export var loop_y:bool = false

@export var state:int = 0
@export var age:int = 0

var values_t0:PackedFloat32Array = PackedFloat32Array()
var values_t1:PackedFloat32Array = PackedFloat32Array()

var xmin:float; var xmax:float; var ymin:float;var ymax:float

func _ready():
	values_t0.resize(SX*SY)
	values_t1.resize(SX*SY)
	for i in range(SX*SY):
		values_t0[i] = 0

	if loop_x == true:
		xmin = 0
		xmax = SX
	else:
		xmin = 1
		xmax = SX-1

	if loop_y == true:
		ymin = 0
		ymax = SY
	else:
		ymin = 1
		ymax = SY-1
		

func _process(_delta):
	if not Engine.is_editor_hint():
		diffusion()
		if show_iso == false:
			display_values()
		else:
			display_iso()
		age += 1
		
func _enter_tree():
	var new_name:String = get_scene_file_path().get_file().trim_suffix(".tscn")
	set_name.call_deferred(new_name)

func diffusion():
	for i in range(xmin,xmax):
		for j in range(ymin,ymax):
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

func display_iso():
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	var r:float; var g:float; var b:float
	for i in range(SX):
		for j in range(SY):
			var p:int = i+j*SX
			var v:float = values_t0[p] # [0, 1]
			var e:float = 0
			if v>0:
				e = sin(30*log(v))
			img.set_pixel(i,j,Color(e*baseColor.r,e*baseColor.g,e*baseColor.b,baseColor.a) )
	set_texture(ImageTexture.create_from_image(img))
		
"""
