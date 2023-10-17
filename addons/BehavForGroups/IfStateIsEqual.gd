@icon("Condition.svg")
class_name IfStateIsEqual
extends BehavForGroups

@export var is_equal_to:int = 0

func biodyn_process(agent:Node)->bool:
	if agent.state == is_equal_to:
		return true
	else:
		return false
