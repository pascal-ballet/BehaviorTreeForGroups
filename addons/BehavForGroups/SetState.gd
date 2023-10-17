@icon("Action.svg")
class_name SetState
extends BehavForGroups

@export var set_to_value:int = 0

func biodyn_process(agent:Node)->bool:
	agent.state = set_to_value
	return true
