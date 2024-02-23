## Return true if the agent's age
## is inf to the given integer number.

@icon("condition.svg")
class_name IfAgeInf
extends BehaviorTreeForGroups

@export var age_inferior_to:int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	if agent.age <= age_inferior_to :
		return true
	else:
		return false
