## Set a float to global scene's data

@icon("action.svg")
class_name GlobalDataSet
extends BehaviorTreeForGroups

@export var global_data_name:String = ""
@export var set_to_value:float = 0

func biodyn_process(agent:Node)->bool:
	if global_data_name != "":
		BTFG.btfg_root.set_meta(global_data_name, set_to_value)
	return true
