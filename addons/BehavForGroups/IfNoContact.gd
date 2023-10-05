@icon("Condition.svg")
class_name IfNoContact
extends BehavForGroups

@export var steps_without_contact:int = 100
var period_of_no_contact:int = 0

func biodyn_process(agent)->bool:
	var bodies = agent.get_colliding_bodies()
	if bodies.size() == 0:
		period_of_no_contact = period_of_no_contact + 1
	else:
		period_of_no_contact = 0 # A contact occurs => reset

	if period_of_no_contact >= steps_without_contact:
		period_of_no_contact = steps_without_contact # avoid go back to MIN int if very very long period without contact
		return true
	else:
		return false
