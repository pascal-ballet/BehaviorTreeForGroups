## Set the state of the current agent

@icon("action.svg")
class_name SetState
extends BehaviorTreeForGroups

## New agent's state value
@export var set_to_value:int = 0
var update_state_at_age:int = -1
var agt:Node = null

func biodyn_process(agent:Node)->bool:
	try_update_state()
	if agent.state != set_to_value:
		update_state_at_age = agent.age+1
		agt = agent
	
	return true

func _process(_delta):
	try_update_state()

func try_update_state():
	if update_state_at_age != -1:
		if is_instance_valid(agt):
			if update_state_at_age <= agt.age:
				agt.state = set_to_value
				update_state_at_age = -1
