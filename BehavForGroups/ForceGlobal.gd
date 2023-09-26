@icon("Action.svg")
class_name ForceGlobal
extends BehavForGroups

@export var fx:float = 0.0
@export var fy:float = 0.0
@export var fz:float = 0.0

func biodyn_process(agent)->bool:
	agent.apply_central_impulse ( Vector3 (fx, fy, fz) )
	return true
