## BehavTreeForGroups
## ******************
## Returns true if a collision occurs
## for the current agent

@icon("Condition.svg")
class_name IfCollision
extends BehavForGroups

## Collider's group
@export var with_group:String = ""
## Group's state (-1 = any state)
@export var in_state:int = -1
## Collider's reference into the common blackboard
var collider_reference:String = "collider"

func biodyn_process(agent)->bool:
	var bodies = agent.get_colliding_bodies()
	if bodies.size() > 0:
		for b in bodies:
			if b.is_in_group(with_group):
				if "state" in b:
					if b.state == in_state || in_state == -1:
						if collider_reference != "":
							get_tree().current_scene.set_meta(collider_reference, b)
						return true
				else: # Not an agent from BehavTreeForGroups
					return true
	return false
