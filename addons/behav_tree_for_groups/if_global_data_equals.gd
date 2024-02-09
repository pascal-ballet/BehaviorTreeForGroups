## Return true if a global's data
## equals a specific float value

@icon("condition.svg")
class_name IfGlobalDataEquals
extends BehaviorTreeForGroups

@export var global_data_name:String = ""
@export var is_equal_to:float = 0

func biodyn_process(agent:Node)->bool:
	if global_data_name != "":
		if BTFG.btfg_root.has_meta(global_data_name):
			var val:float = BTFG.btfg_root.get_meta(global_data_name)
			if val == is_equal_to:
				return true
	return false
