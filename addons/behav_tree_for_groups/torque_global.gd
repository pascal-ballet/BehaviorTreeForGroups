## Apply a torque on the current agent
## according to the absolute axis reference

@icon("action.svg")
class_name TorqueGlobal
extends BehaviorTreeForGroups

@export var rx:float = 0.0
@export var ry:float = 0.0
@export var rz:float = 0.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		agent.apply_torque_impulse ( Vector3 (rx, ry, rz) )
		return true

	if agent is RigidBody2D:
		agent.apply_torque_impulse ( rz )
		return true

	return false
