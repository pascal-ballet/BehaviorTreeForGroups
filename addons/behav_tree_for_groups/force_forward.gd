## BehavTreeForGroups
## ******************
## Applies a forward force to the current agent

@icon("action.svg")
class_name ForceForward
extends BehaviorTreeForGroups

@export var fx:float = 0.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		agent.apply_central_impulse(agent.transform.basis.x * fx)
		return true
		
	if agent is RigidBody2D:
		agent.apply_central_impulse(agent.transform.basis.x * fx)
		return true

	return false
