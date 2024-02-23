## Return true when the data's value is 
## inside the specified interval and 
## periodically for each gap of the step size.

@icon("condition.svg")
class_name IfDataEqualsPeriodicValues
extends BehaviorTreeForGroups



@export var data_name:String = ""
## Size of each step
@export var period: float = 0
@export var min_data: float = 0
## Put -1 for infinite
@export var max_data: float = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	if data_name != "":
		if agent.has_meta(data_name):
			var data_value:float = agent.get_meta(data_name)
			if max_data == -1 :
				if data_value >= min_data :
					if modulo( (data_value-min_data), period) == true :
						return true
					else :
						return false
				else :
					return false
			elif data_value >= min_data and data_value <= max_data:
				if modulo( (data_value-min_data), period) == true :
					return true
				else :
					return false
			else:
				return false
		else :
			return false
	else :
		return false

func modulo(val:float, period:float) -> bool:
	var rest:int = val / period
	if (val / period) == rest:
		return true
	else:
		return false
