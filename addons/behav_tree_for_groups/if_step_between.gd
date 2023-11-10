## BehavTreeForGroups
## ******************
## Return true if the simulation/execution step
## is between 2 given integer numbers.

@icon("condition.svg")
class_name IfStepBetween
extends BehaviorTreeForGroups

## Initial simulation/execution step
@export var step_start:int = 0
## Final simulation/execution step
@export var step_end:int = 100

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var step:int = BehaviorTreeForGroups.simulation_step
	if step >= step_start and step <= step_end:
		return true
	else:
		return false
