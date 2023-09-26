@icon("Action.svg")
class_name ForceForward
extends BehavForGroups

@export var fx:float = 0.0

func biodyn_process(agent:RigidBody3D)->bool:
	agent.apply_central_impulse(agent.transform.basis.x * fx)
	return true
