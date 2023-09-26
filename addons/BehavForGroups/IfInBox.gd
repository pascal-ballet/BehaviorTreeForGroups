@icon("Condition.svg")
class_name IfInBox
extends BehavForGroups

@export var x_min:float = -5
@export var x_max:float = 5
@export var y_min:float = -5
@export var y_max:float = 5
@export var z_min:float = -5
@export var z_max:float = 5

func biodyn_process(agent:Node) -> bool:
	var x:float = agent.position.x
	var y:float = agent.position.y
	var z:float = agent.position.z

	# X Axis
	if x < x_min:
		return false
	if x > x_max:
		return false
	# Y Axis
	if y < y_min:
		return false
	if y > y_max:
		return false
	# Z Axis
	if z < z_min:
		return false
	if z > z_max:
		return false

	return true
