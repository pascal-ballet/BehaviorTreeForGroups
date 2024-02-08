## Add a float to a current global's data

@icon("action.svg")
class_name GlobalDataPlus
extends BehaviorTreeForGroups

@export var global_data_name:String = ""
@export var add_value:float = 0

func biodyn_process(agent:Node)->bool:
	if global_data_name != "":
		if BTFG.btfg_root.has_meta(global_data_name):
			var val:float = 0
			val = BTFG.btfg_root.get_meta(global_data_name)
			val = val + add_value
			BTFG.btfg_root.set_meta(global_data_name, val)
	return true
