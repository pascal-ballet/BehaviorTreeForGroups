## Set an int to a current agent's age

@icon("action.svg")
class_name SetAge
extends BehaviorTreeForGroups

## New agent's age value
@export var age:int = 0

func biodyn_process(agent:Node)->bool:
	agent.age = age
	return true
