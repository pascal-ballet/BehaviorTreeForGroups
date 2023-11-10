## BehavTreeForGroups
## ******************
## Apply a random torque on the current agent.

@icon("action.svg")
class_name TorqueRandom
extends BehaviorTreeForGroups

@export var rx:float = 1.0
@export var ry:float = 1.0
@export var rz:float = 1.0

func biodyn_process(agent)->bool:
	if agent is Node3D:
		var rrx:float = rx * (randf() - 0.5)
		var rry:float = ry * (randf() - 0.5)
		var rrz:float = rz * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_torque_impulse ( Vector3 (rrx, rry, rrz) )
		return true

	if agent is Node2D:
		var rrz:float = rz * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_torque_impulse ( rrz )
		return true

	return false
