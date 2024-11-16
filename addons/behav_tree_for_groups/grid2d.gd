@tool
extends TextureRect

@export var baseColor:Color = Color(0.5,0.5,0.5,0.5)
@export var diffusionRate = 0.3
@export var degradationRate = 0.001
@export var display_value:bool = false
@export var show_iso:bool = false

@export var SX:int = 64
@export var SY:int = 32
@export var loop_x:bool = false
@export var loop_y:bool = false

@export var state:int = 0
@export var age:int = 0

@export var fields:Array[Field] = []
@export var reactions:Array[Reaction] = []

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
		if display_value == true:
			print_value()
		age += 1

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
	
func print_value():
	var i:int   = randi_range(0, SX-1)
	var j:int   = randi_range(0, SY-1)
	var v:float = values_t0[i+j*SX]
	print("At (" + str(i) + "," + str(j) + ")=" + str(num_zeros(v)) + "<=" + str(v) )

func num_zeros(val:float) -> int:
	var n:int = 0
	if val != 0:
		n = -floor(   log(abs(val)) / log(10)  ) - 1
	return n

func display_iso():
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	var r:float; var g:float; var b:float
	for i in range(1,SX-2):
		for j in range(1,SY-2):
			var p:int = i+j*SX
			var v0:float = num_zeros(values_t0[p])
			var vg:float = num_zeros(values_t0[p-1])
			var vd:float = num_zeros(values_t0[p+1])
			var vh:float = num_zeros(values_t0[p-SX])
			var vb:float = num_zeros(values_t0[p+SX])
			var e:float = 1.0
			if vg>v0 || vd>v0 || vh>v0 || vb>v0:
				e = 0.5
			img.set_pixel(i,j,Color(e*baseColor.r,e*baseColor.g,e*baseColor.b,baseColor.a) )
	set_texture(ImageTexture.create_from_image(img))
