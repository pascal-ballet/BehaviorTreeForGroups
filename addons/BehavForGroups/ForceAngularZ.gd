@icon("Action.svg")
class_name ForceAngularZ
extends BehavForGroups

@export var center:Vector3
@export var intensity:float = 1.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		var dv:Vector3 = center - agent.position.normalized()
		var du:Vector3 = Vector3(-dv.y, dv.x, 0)
		agent.apply_central_impulse ( intensity*du )
		return true
	if agent is RigidBody2D:
		var dv:Vector2 = Vector2(center.x, center.y) - agent.position.normalized()
		var du:Vector2 = Vector2(-dv.y, dv.x)
		agent.apply_central_impulse ( intensity*du )
		return true
		
	return false
