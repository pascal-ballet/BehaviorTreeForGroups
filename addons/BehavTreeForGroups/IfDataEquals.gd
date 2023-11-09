## BehavTreeForGroups
## ******************
## Return true if an agent's data
## equals a specific float value

@icon("Condition.svg")
class_name IfDataEquals
extends BehavForGroups

@export var data_name:String = ""
@export var is_equal_to:float = 0

func biodyn_process(agent:Node)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var val:float = 0
			val = agent.get_meta(data_name)
			if val == is_equal_to:
				return true
	return false
