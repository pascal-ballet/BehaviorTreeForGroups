## BehavTreeForGroups
## ******************
## Apply a random translation
## on the current agent.

@icon("action.svg")
class_name TranslateRandom
extends BehaviorTreeForGroups

## Maximum sizes of the random vector
@export var delta:Vector3 = Vector3(1,1,1)

func biodyn_process(agent)->bool:
	if agent is Node3D:
		var ddx:float = randf()*delta.x - delta.x / 2.0
		var ddy:float = randf()*delta.y - delta.y / 2.0
		var ddz:float = randf()*delta.z - delta.z / 2.0
		agent.translate ( Vector3 (ddx, ddy, ddz) )
		return true

	if agent is Node2D:
		var ddx:float = randf()*delta.x - delta.x / 2.0
		var ddy:float = randf()*delta.y - delta.y / 2.0
		agent.translate ( Vector2 (ddx, ddy) )
		return true

	return false
