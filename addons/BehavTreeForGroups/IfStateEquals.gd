## BehavTreeForGroups
## ******************
## Return true if the agent's state
## equals a given integer value

@icon("Condition.svg")
class_name IfStateEquals
extends BehavForGroups

## Test the state value (-1 for any state)
@export var state_equals:int = 0

func biodyn_process(agent:Node)->bool:
	if agent.state == state_equals || state_equals == -1:
		return true
	else:
		return false
