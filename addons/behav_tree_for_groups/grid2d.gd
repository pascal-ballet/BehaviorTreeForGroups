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
			if fields[f] != null:
				if fields[f].initialisation == "0":
					values[f] = 0.0
				elif fields[f].initialisation == "1":
					values[f] = 1.0
				elif fields[f].initialisation == "Random":
					values[f] = randf()
				if loop_x == false and (i == 0 or i == SX-1) : # borders are exluded if non toric matrix
					values[f] = 0.0
				if loop_y == false and (j == 0 or j == SY-1):
					values[f] = 0.0
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
		if f!= null:
			fields_dico[f.name]=id
		id += 1

	# reactions init
	for r in reactions:
		if r!=null:
			r.extract_coef_field()
			if fields_dico.has(r.reactive_1) == false:
				r.reactive_1 = "-"
			if fields_dico.has(r.reactive_2) == false:
				r.reactive_2 = "-"
			if fields_dico.has(r.reactive_3) == false:
				r.reactive_3 = "-"
			if fields_dico.has(r.product_1) == false:
				r.product_1 = "-"
			if fields_dico.has(r.product_2) == false:
				r.product_2 = "-"
			if fields_dico.has(r.product_3) == false:
				r.product_3 = "-"

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
		if r != null:
			for i in range(xmin,xmax):
				for j in range(ymin,ymax):
					var p:int = i+j*SX
					r1 = fields_dico[r.reactive_1]
					r2 = fields_dico[r.reactive_2]
					r3 = fields_dico[r.reactive_3]
					p1 = fields_dico[r.product_1]
					p2 = fields_dico[r.product_2]
					p3 = fields_dico[r.product_3]
					s = r.speed
					
					# NO reactive
					if r1 < 0 and r2 < 0 and r3 < 0:
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += s*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += s*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += s*r.coef_p3
					# Only ONE reactive (r1)
					if r1 >= 0 and r2 < 0 and r3 < 0:
						var d_qte:float = s * values_t0[p].values[r1]
						values_t0[p].values[r1] -= d_qte*r.coef_r1
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# Only ONE reactive (r2)
					if r1 < 0 and r2 >= 0 and r3 < 0:
						var d_qte:float = s * values_t0[p].values[r2]
						values_t0[p].values[r2] -= d_qte*r.coef_r2
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# Only ONE reactive (r3)
					if r1 < 0 and r2 < 0 and r3 >= 0:
						var d_qte:float = s * values_t0[p].values[r3]
						values_t0[p].values[r3] -= d_qte*r.coef_r3
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# TWO reactives (r1+r2)
					if r1 >=0 and r2 >= 0 and r3 < 0:
						var d_qte:float = s * values_t0[p].values[r1] * values_t0[p].values[r2]
						values_t0[p].values[r1] -= d_qte*r.coef_r1
						values_t0[p].values[r2] -= d_qte*r.coef_r2
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# TWO reactives (r1+r3)
					if r1 >=0 and r2 < 0 and r3 >= 0:
						var d_qte:float = s * values_t0[p].values[r1] * values_t0[p].values[r3]
						values_t0[p].values[r1] -= d_qte*r.coef_r1
						values_t0[p].values[r3] -= d_qte*r.coef_r3
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# TWO reactives (r1+r3)
					if r1 < 0 and r2 >= 0 and r3 >= 0:
						var d_qte:float = s * values_t0[p].values[r2] * values_t0[p].values[r3]
						values_t0[p].values[r2] -= d_qte*r.coef_r2
						values_t0[p].values[r3] -= d_qte*r.coef_r3
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3
					# THREE reactives (r1+r2+r3)
					if r1 >= 0 and r2 >= 0 and r3 >= 0:
						var d_qte:float = s * values_t0[p].values[r1] * values_t0[p].values[r2] * values_t0[p].values[r3]
						values_t0[p].values[r1] -= d_qte*r.coef_r1
						values_t0[p].values[r2] -= d_qte*r.coef_r2
						values_t0[p].values[r3] -= d_qte*r.coef_r3
						# if product
						if p1 >= 0:
							values_t0[p].values[p1] += d_qte*r.coef_p1
						if p2 >= 0:
							values_t0[p].values[p2] += d_qte*r.coef_p2
						if p3 >= 0:
							values_t0[p].values[p3] += d_qte*r.coef_p3

	# Diffusion
	for f in fields.size():
		if fields[f] != null:
			var degrad:float = fields[f].degradation_speed
			var diffus:float = fields[f].diffusion_speed
			for i in range(xmin,xmax):
				for j in range(ymin,ymax):
					var p:int = i+j*SX
					var v0:float = values_t0[ (i+1)%SX+j*SX].values[f]
					var v1:float = values_t0[ (i-1+SX)%SX+j*SX].values[f]
					var v2:float = values_t0[ i%SX+((j+1)%SY)*SX].values[f]
					var v3:float = values_t0[ i%SX+((j-1+SY)%SY)*SX].values[f]
					values_t1[p].values[f] = (1.0-degrad)*(1.0-diffus)*values_t0[p].values[f] + diffus*(v0+v1+v2+v3)*0.25
		
			for i in range(SX*SY):
				values_t0[i].values[f] = values_t1[i].values[f]


func display_values():
	var img:Image = Image.create(SX,SY,false, Image.FORMAT_RGBA8)
	for f in fields.size():
		if fields[f] != null:
			for i in range(SX):
				for j in range(SY):
					var p:int = i+j*SX
					var v:float = values_t0[p].values[f]
					var col:Color = img.get_pixel(i,j)
					var baseColor:Color = fields[f].color
					var R = max(0.1, min(v*baseColor.r+col.r,0.9))
					var G = max(0.1, min(v*baseColor.g+col.g,0.9))
					var B = max(0.1, min(v*baseColor.b+col.b,0.9))
					img.set_pixel(i,j,Color(R,G,B,opacity) )
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
