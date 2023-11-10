## BehavTreeForGroups
## ******************
## Duplicate the current node/agent

@icon("action.svg")

class_name CloneAgent
extends BehaviorTreeForGroups

func biodyn_process(agent) -> bool:
	# Clone agent to the Scene
	var nb_agents:int = get_tree().current_scene.get_child_count()
	if nb_agents < BehaviorTreeForGroups.max_agents:
		var spawn = agent.duplicate(15)
		# Put and translate the spawn in the scene
		get_tree().current_scene.add_child(spawn)

	return true
