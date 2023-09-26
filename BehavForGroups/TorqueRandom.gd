@icon("Action.svg")
class_name TorqueRandom
extends BehavForGroups

@export var rx:float = 1.0
@export var ry:float = 1.0
@export var rz:float = 1.0

func biodyn_process(agent)->bool:
	var rrx:float = rx * (randf() - 0.5)
	var rry:float = ry * (randf() - 0.5)
	var rrz:float = rz * (randf() - 0.5)
	#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
	agent.apply_torque_impulse ( Vector3 (rrx, rry, rrz) )
	return true
