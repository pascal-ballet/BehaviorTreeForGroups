@icon("Action.svg")
class_name ForceRadial
extends BehavForGroups

@export var center:Vector3
@export var intensity:float = 1.0

func biodyn_process(agent)->bool:
	var dv:Vector3 = center - agent.position.normalized()
	agent.apply_central_impulse ( intensity*dv )
	return true
