## Return true if the global's data
## is between 2 given float values.

@icon("condition.svg")
class_name IfGlobalDataBetween
extends BehaviorTreeForGroups

@export var global_data_name:String = ""
@export var min:float = 0
@export var max:float = 0

func biodyn_process(agent:Node)->bool:
	if global_data_name != "":
		if BTFG.btfg_root.has_meta(global_data_name):
			var val:float = BTFG.btfg_root.get_meta(global_data_name)
			if val >= min and val <= max:
				return true
	return false
