## Return true if an agent
## is inside box

@icon("condition.svg")
class_name IfInBox
extends BehaviorTreeForGroups

@export var min:Vector3 = Vector3(-5,-5,-5)
@export var max:Vector3 = Vector3(5,5,5)

func biodyn_process(agent:Node) -> bool:
	if agent is Node3D:
		var x:float = agent.position.x
		var y:float = agent.position.y
		var z:float = agent.position.z

		# X Axis
		if x < min.x:
			return false
		if x > max.x:
			return false
		# Y Axis
		if y < min.y:
			return false
		if y > max.y:
			return false
		# Z Axis
		if z < min.z:
			return false
		if z > max.z:
			return false

		return true

	if agent is Node2D:
		var x:float = agent.position.x
		var y:float = agent.position.y

		# X Axis
		if x < min.x:
			return false
		if x > max.x:
			return false
		# Y Axis
		if y < min.y:
			return false
		if y > max.y:
			return false

		return true
	
	return false
