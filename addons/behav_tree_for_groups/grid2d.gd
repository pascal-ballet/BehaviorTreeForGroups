@tool
extends TextureRect

@export var SX:int = 64
@export var SY:int = 32
@export var loop_x:bool = false
@export var loop_y:bool = false

@export var fields:Array[Field] = []
@export var reactions:Array[Reaction] = []

@export var opacity:float = 1.0
#@export var show_iso:bool = false
@export var print_values:bool = false

@export var state:int = 0
@export var age:int = 0

var values_t0:Array[data] = []
var values_t1:Array[data] = []

var xmin:float; var xmax:float; var ymin:float;var ymax:float

# Store the values of each field for ONE position in the matrix
# Each data stores one qte of all the Fields
class data:
	var values:Array[float] = []
	func _init(fields:Array[Field], i:int, j:int, SX:int, SY:int, loop_x:bool, loop_y:bool):
		values.resize(fields.size())
		for f in fields.size():
var fields_dico:Dictionary

func _ready():
	# loop or not loop
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
		
	# Init matrix values
	values_t0.resize(SX*SY)
	values_t1.resize(SX*SY)
	for i in SX:
		for j in SY:
			values_t0[i+j*SX] = data.new(fields, i, j, SX, SY, loop_x, loop_y) # Call the constructor (_init)
			values_t1[i+j*SX] = data.new(fields, i, j, SX, SY, loop_x, loop_y)

	# fields names => id: allow a quick access of fields names during reactions
	var id:int = 0
	fields_dico["-"]=-1
	for f in fields:
		id += 1

	# reactions init
	for r in reactions:

func _process(_delta):
	if not Engine.is_editor_hint():
		reaction_diffusion()
		#if show_iso == false:
		display_values()
		#else:
		#	display_iso()
		if print_values == true:
			print_all_values()
		age += 1

func reaction_diffusion():
	# Reaction
	var r1 : int
	var r2 : int
	var r3 : int
	var s  : float
	var p1 : int
	var p2 : int
	var p3 : int
	
	for r in reactions:
	# Diffusion
	for f in fields.size():

func display_values():
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	for f in fields.size():
	set_texture(ImageTexture.create_from_image(img))
	
func print_all_values():
	var i:int   = randi_range(0, SX-1)
	var j:int   = randi_range(0, SY-1)
	for f in fields.size():
		var v:float = values_t0[i+j*SX].values[f]
		print("At (" + str(i) + "," + str(j) + ")=" + str(num_zeros(v)) + "<=" + str(v) )

func num_zeros(val:float) -> int:
	var n:int = 0
	if val != 0:
		n = -floor(   log(abs(val)) / log(10)  ) - 1
	return n

func display_iso():
	return
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
