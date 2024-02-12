## Return true if the time's data
## is between 2 given float values.

@icon("condition.svg")
class_name IfTimeBetween
extends BehaviorTreeForGroups

@export var start_time_ms:int = 0
@export var end_time_ms:int = 0

func biodyn_process(agent:Node)->bool:
	var val:int = Time.get_ticks_msec()
	if val >= start_time_ms and val <= end_time_ms:
		return true
	return false
