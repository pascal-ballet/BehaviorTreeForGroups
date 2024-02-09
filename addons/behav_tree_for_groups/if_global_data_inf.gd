## Return true if a global's data
## is inferior to a float value

@icon("condition.svg")
class_name IfGlobalDataInf
extends BehaviorTreeForGroups

@export var global_data_name:String = ""
@export var is_inf_to:float = 0

func biodyn_process(agent:Node)->bool:
	if global_data_name != "":
		if BTFG.btfg_root.has_meta(global_data_name):
			var val:float = BTFG.btfg_root.get_meta(global_data_name)
			if val <= is_inf_to:
				return true
	return false
