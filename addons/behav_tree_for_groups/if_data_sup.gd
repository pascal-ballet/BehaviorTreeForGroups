## Return true if an agent's data
## is superior to a float value

@icon("condition.svg")
class_name IfDataSup
extends BehaviorTreeForGroups

@export var data_name:String = ""
@export var is_sup_to:float = 0

func biodyn_process(agent:Node)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var val:float = 0
			val = agent.get_meta(data_name)
			if val > is_sup_to:
				return true
	return false
