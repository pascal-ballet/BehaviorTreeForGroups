## BehavTreeForGroups
## ******************
## Add a float to a current agent's data

@icon("action.svg")
class_name DataPlus
extends BehaviorTreeForGroups

@export var data_name:String = ""
@export var add_value:float = 0

func biodyn_process(agent:Node)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var val:float = 0
			val = agent.get_meta(data_name)
			val = val + add_value
			agent.set_meta(data_name, val)
	return true
