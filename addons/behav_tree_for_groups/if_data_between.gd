## Return true if the agent's data
## is between 2 given float values.

@icon("condition.svg")
class_name IfDataBetween
extends BehaviorTreeForGroups

@export var data_name:String = ""
@export var data_min:float = 0
@export var data_max:float = 0

func biodyn_process(agent:Node)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var val:float = 0
			val = agent.get_meta(data_name)
			if val >= data_min and val <= data_max:
				return true
	return false
