@tool
extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_tree():
	var name = get_scene_file_path().get_file().trim_suffix(".tscn")
	
func _duplicate():
	name = get_scene_file_path().get_file().trim_suffix(".tscn")

