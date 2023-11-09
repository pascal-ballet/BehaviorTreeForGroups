## BehavTreeForGroups
## ******************
## Remove the current agent from the scene

@icon("Action.svg")
class_name Delete
extends BehavForGroups

func biodyn_process(agent)->bool:
	agent.queue_free()
	return true
