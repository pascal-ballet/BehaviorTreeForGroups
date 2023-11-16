## Return true if the simulation/execution step
## is between 2 given integer numbers.

@icon("condition.svg")
class_name IfAgeBetween
extends BehaviorTreeForGroups

## Initial simulation/execution step
@export var age_start:int = 0
## Final simulation/execution step
@export var age_end:int = 100

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var age:int = agent.age
	if age >= age_start and age <= age_end:
		return true
	else:
		return false
