extends Resource

class_name Field

@export var name:String = "Field"
@export var color:Color = Color.BLUE
@export_range(0.0, 1.0) var diffusion_speed:float = 0.3
@export var degradation_speed:float = 0.001
@export_enum("0", "1", "Random") var initialisation: String = "0"
