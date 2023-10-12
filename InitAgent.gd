@tool
extends RigidBody3D

var _old_name = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_tree():
	print("I am entering_tree !!!")
	remove_from_group(_old_name)
	print("I remove group:"+_old_name)
	var type_name = get_scene_file_path().get_file().trim_suffix(".tscn")
	add_to_group(type_name, true)
	_old_name = type_name
	print("I add group:"+name)
	

func emit_changed():
	print("La ressource a été renommée en:")
