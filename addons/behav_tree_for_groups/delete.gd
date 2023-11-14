## Remove the current agent from the scene

@icon("action.svg")
class_name Delete
extends BehaviorTreeForGroups

func biodyn_process(agent)->bool:
	agent.queue_free()
	return true
