extends Resource
class_name Reaction

var coef_r1:int = 0
@export var reactive_1:String = ""
var coef_r2:int = 0
@export var reactive_2:String = ""
var coef_r3:int = 0
@export var reactive_3:String = ""

@export var speed:float = 0.01

var coef_p1:int = 0
@export var product_1:String = ""
var coef_p2:int = 0
@export var product_2:String = ""
var coef_p3:int = 0
@export var product_3:String = ""

func extract_coef_field():
	
	# reactives
	var lst_r1 = reactive_1.split(" ")
	if lst_r1.size() == 1:
		coef_r1 = 1
		reactive_1 = lst_r1[0]
	if lst_r1.size() == 2:
		coef_r1 = int(lst_r1[0])
		reactive_1 = lst_r1[1]
	
	var lst_r2 = reactive_2.split(" ")
	if lst_r2.size() == 1:
		coef_r2 = 1
		reactive_2 = lst_r2[0]
	if lst_r2.size() == 2:
		coef_r2 = int(lst_r2[0])
		reactive_2 = lst_r2[1]
	
	var lst_r3 = reactive_3.split(" ")
	if lst_r3.size() == 1:
		coef_r3 = 1
		reactive_3 = lst_r3[0]
	if lst_r3.size() == 2:
		coef_r3 = int(lst_r3[0])
		reactive_3 = lst_r3[1]

	# products
	var lst_p1 = product_1.split(" ")
	if lst_p1.size() == 1:
		coef_p1 = 1
		product_1 = lst_p1[0]
	if lst_p1.size() == 2:
		coef_p1 = int(lst_p1[0])
		product_1 = lst_p1[1]
	
	var lst_p2 = product_2.split(" ")
	if lst_p2.size() == 1:
		coef_p2 = 1
		product_2 = lst_p2[0]
	if lst_p2.size() == 2:
		coef_p2 = int(lst_p2[0])
		product_2 = lst_p2[1]
	
	var lst_p3 = product_3.split(" ")
	if lst_p3.size() == 1:
		coef_p3 = 1
		product_3 = lst_p3[0]
	if lst_p3.size() == 2:
		coef_p3 = int(lst_p3[0])
		product_3 = lst_p3[1]
