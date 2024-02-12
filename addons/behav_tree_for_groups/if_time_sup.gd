## Return true if the time
## is superior to a specific
## int value snapped by 20.

@icon("condition.svg")
class_name IfTimeSup
extends BehaviorTreeForGroups
@export var is_superior_to_ms:int = 0

func biodyn_process(agent:Node)->bool:
	var val:int = Time.get_ticks_msec()
	if val >= is_superior_to_ms :
		return true
	else :
		return false
