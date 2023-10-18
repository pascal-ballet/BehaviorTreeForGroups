@icon("Condition.svg")
class_name IfStateIsEqual
extends BehavForGroups

@export var state_equals:int = 0

func biodyn_process(agent:Node)->bool:
	if agent.state == state_equals:
		return true
	else:
		return false
