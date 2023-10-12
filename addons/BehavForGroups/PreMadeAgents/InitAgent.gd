extends RigidBody3D

@export var color:Color = Color.BLUE
@export var groupe_1:String = ""
@export var groupe_2:String = ""
@export var groupe_3:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# The name is autommatically added
	if self.is_in_group(groupe_1) == false:
		self.add_to_group(groupe_1)
	if self.is_in_group(groupe_2) == false:
		self.add_to_group(groupe_2)
	if self.is_in_group(groupe_3) == false:
		self.add_to_group(groupe_3)
	var mat:StandardMaterial3D = StandardMaterial3D.new()
