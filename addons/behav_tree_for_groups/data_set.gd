## BehavTreeForGroups
## ******************
## Set a float to a current agent's data

@icon("action.svg")
class_name DataSet
extends BehaviorTreeForGroups

@export var data_name:String = ""
@export var set_to_value:float = 0

func biodyn_process(agent:Node)->bool:
	if data_name != "":
		agent.set_meta(data_name, set_to_value)
	return true
