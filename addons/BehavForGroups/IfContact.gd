@icon("Condition.svg")
class_name IfContact
extends BehavForGroups

@export var contact_agent:String = ""

func biodyn_process(agent)->bool:
	var bodies = agent.get_colliding_bodies()
	if bodies.size() > 0:
		for b in bodies:
			if b.is_in_group(contact_agent):
				return true
	return false
