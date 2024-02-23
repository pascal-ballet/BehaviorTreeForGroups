## Return true if the data's value
## equals one of the given values.

@icon("condition.svg")
class_name IfDataEqualsValues
extends BehaviorTreeForGroups
@export var data_name:String = ""
@export var values:Array[float] = [10,20,25]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var data_value:float = agent.get_meta(data_name)
			if values.find(data_value) >= 0 :
				return true
			else:
				return false
		else :
			return false
	else :
		return false
