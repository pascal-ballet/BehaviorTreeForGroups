@icon("Condition.svg")
class_name IfStepBetween
extends BehavForGroups

@export var step_start:int = 0
@export var step_end:int = 100

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var step:int = BehavForGroups.simulation_step
	if step >= step_start and step <= step_end:
		return true
	else:
		return false
