extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# The name is autommatically added
	if self.is_in_group(self.source_file) == false:
		self.add_to_group(self.name)
