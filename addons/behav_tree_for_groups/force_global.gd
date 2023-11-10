## BehavTreeForGroups
## ******************
## Applies a force to the current agent
## relating to the absolute axis reference

@icon("action.svg")
class_name ForceGlobal
extends BehaviorTreeForGroups

@export var fx:float = 0.0
@export var fy:float = 0.0
@export var fz:float = 0.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		agent.apply_central_impulse ( Vector3 (fx, fy, fz) )
		return true
	if agent is RigidBody2D:
		agent.apply_central_impulse ( Vector2 (fx, fy) )
		return true
	return false
