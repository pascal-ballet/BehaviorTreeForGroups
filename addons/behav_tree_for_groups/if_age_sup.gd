## Return true if the agent's age
## is equal to the given integer number.

@icon("condition.svg")
class_name IfAgeSup
extends BehaviorTreeForGroups

@export var age_superior_to:int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	if agent.age >= age_superior_to :
		return true
	else:
		return false
