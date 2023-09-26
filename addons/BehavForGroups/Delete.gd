@icon("Action.svg")
class_name Delete
extends BehavForGroups

func biodyn_process(agent)->bool:
	agent.queue_free()
	return true
