@icon("Action.svg")
@tool

class_name Agent3D
extends RigidBody3D

@export var color:Color :
	get:
		return color
	set(value):
		color = value
		get_child(1).material_override.albedo_color = color

@export var groupe_1:String = ""
@export var groupe_2:String = ""
@export var groupe_3:String = ""

func _ready():
	# The name is autommatically added
	if self.is_in_group(groupe_1) == false:
		self.add_to_group(groupe_1)
	if self.is_in_group(groupe_2) == false:
		self.add_to_group(groupe_2)
	if self.is_in_group(groupe_3) == false:
		self.add_to_group(groupe_3)
	#var mat:StandardMaterial3D = StandardMaterial3D.new()


func _enter_tree():
	# Add the collision shape 3D
	var col:CollisionShape3D = CollisionShape3D.new()
	col.set_shape(SphereShape3D.new())
	add_child(col)
	# New mat
	var mat:StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_color = color	
	# Add the meshinstance 3D
	var msh:MeshInstance3D = MeshInstance3D.new()
	msh.set_mesh(SphereMesh.new())
	msh.material_override = mat
	add_child(msh)
	
	
