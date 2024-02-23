## Duplicate the current node/agent in a position chosen

@icon("action_2d.svg")

class_name CloneAgentAtPos2D
extends BehaviorTreeForGroups

@export var relative:bool = true
@export var x:float = 0
@export var y:float = 0

#position
var newpos : Vector2
var rx : float
var ry : float

func biodyn_process(agent) -> bool:
	#create the position of the clone
	if agent is RigidBody2D :
		if relative == true:
			rx = x+agent.position.x
			ry = y+agent.position.y
			newpos = Vector2(rx, ry)
		else :
			newpos = Vector2(x, y)
		#print(newpos)
		# Clone agent to the Scene
		var nb_agents:int = get_tree().current_scene.get_child_count()
		if nb_agents < BehaviorTreeForGroups.max_agents:
			var spawn = agent.duplicate(15)
			#assign the position
			spawn.position = newpos
			# Put and translate the spawn in the scene
			get_tree().current_scene.add_child(spawn)
	return true
