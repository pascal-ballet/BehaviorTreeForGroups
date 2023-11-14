## Applies a centrifuge or centripet force to the current agent
## relating to the center

@icon("action.svg")
class_name ForceRadial
extends BehaviorTreeForGroups

## Center of the force field
@export var center:Vector3
## Intensity of the force field
@export var intensity:float = 1.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		var dv:Vector3 = center - agent.position.normalized()
		agent.apply_central_impulse ( intensity*dv )
		return true

	if agent is RigidBody2D:
		var dv:Vector2 = Vector2(center.x, center.y) - agent.position.normalized()
		agent.apply_central_impulse ( intensity*dv )
		return true

	return false
