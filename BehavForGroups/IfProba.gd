@icon("Condition.svg")
class_name IfProba
extends BehavForGroups

@export var proba:float = 0.1

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var rnd:float = randf()
	if rnd < proba:
		return true
	else:
		return false
