## Duplicate the current node/agent in a position chosen

@icon("action_3d.svg")

class_name CloneAgentAtPos3D
extends BehaviorTreeForGroups

@export var relative:bool = true
@export var x :float = 1 
@export var y :float = 1 
@export var z :float = 1 

#position
var newpos : Vector3
var rx : float
var ry : float
var rz : float

func biodyn_process(agent) -> bool:
	#create the position of the clone
	if agent is RigidBody3D :
		if relative == true :
			rx = x+agent.position.x
			ry = y+agent.position.y
			rz = z+agent.position.z
			newpos = Vector3(rx, ry, rz)
		else :
			newpos = Vector3(x, y, z)
		var nb_agents:int = get_tree().current_scene.get_child_count()
		if nb_agents < BehaviorTreeForGroups.max_agents:
			var spawn = agent.duplicate(15)
			#assign the position
			spawn.position = newpos
			# Put and translate the spawn in the scene
			get_tree().current_scene.add_child(spawn)
	return true
