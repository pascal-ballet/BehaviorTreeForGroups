## Return true if an agent has no collision
## with a specific group in a designated
## state during several execution steps.

@icon("condition.svg")
class_name IfNoContactWith
extends BehaviorTreeForGroups

## Contact's group
@export var with_group:String = ""
@export var steps_without_contact:int = 100
var period_of_no_contact:int = 0
## Group's state (-1 = any state)
@export var in_state:int = -1

func biodyn_process(agent)->bool:
	var bodies = agent.get_colliding_bodies()
	var col:bool = false
	for b in bodies:
		if b.is_in_group(with_group):
			if "state" in b:
				if b.state == in_state || in_state == -1:
					col = true
					
	if col == false:
		period_of_no_contact = period_of_no_contact + 1
	else:
		period_of_no_contact = 0 # A contact occurs => reset

	if period_of_no_contact >= steps_without_contact:
		period_of_no_contact = steps_without_contact # avoid go back to MIN int if very very long period without contact
		return true
	else:
		return false
