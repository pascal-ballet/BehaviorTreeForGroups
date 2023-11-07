@icon("Action.svg")
class_name SetState
extends BehavForGroups

## New agent's state value
@export var set_to_value:int = 0
var update_state_at_age:int = 0
var agt:Node = null

func biodyn_process(agent:Node)->bool:
	if agent.state != set_to_value:
		update_state_at_age = agent.age+1
		agt = agent
	
	return true

func _process(_delta):
	if update_state_at_age != 0:
		if update_state_at_age == agt.age:
			agt.state = set_to_value
			update_state_at_age = 0

