## BehavTreeForGroups
## ******************
## Apply a torque on the current agent
##according to the absolute axis reference

@icon("Action.svg")
class_name TorqueGlobal
extends BehavForGroups

@export var rx:float = 0.0
@export var ry:float = 0.0
@export var rz:float = 0.0

func biodyn_process(agent)->bool:
	if agent is Node3D:
		agent.apply_torque_impulse ( Vector3 (rx, ry, rz) )
		return true

	if agent is Node2D:
		agent.apply_torque_impulse ( Vector2 (rx, ry) )
		return true

	return false
