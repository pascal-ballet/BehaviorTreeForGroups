@icon("Action.svg")
class_name ForceAngularZ
extends BehavForGroups

@export var center:Vector3
@export var intensity:float = 1.0

func biodyn_process(agent)->bool:
	var dv:Vector3 = center - agent.position.normalized()
	var du:Vector3 = Vector3(-dv.y, dv.x, 0)
	agent.apply_central_impulse ( intensity*du )
	return true
