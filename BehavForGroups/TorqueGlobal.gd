@icon("Action.svg")
class_name TorqueGlobal
extends BehavForGroups

@export var rx:float = 0.0
@export var ry:float = 0.0
@export var rz:float = 0.0

func biodyn_process(agent)->bool:
	agent.apply_torque_impulse ( Vector3 (rx, ry, rz) )
	return true
