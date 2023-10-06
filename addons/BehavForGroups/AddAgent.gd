@icon("Action.svg")

class_name AddAgent
extends BehavForGroups

#@export var agent_path:String = ""
@export_file("*.tscn") var agent_tscn: String

var root:Node = null
var new_agent_scene:Resource = null
var new_agent_behaviors:Array = []
var new_agent_prototype:Node = null

func biodyn_process(agent) -> bool:
	if agent_tscn != "":
		# Initilize the Agent to clone
		if new_agent_scene == null:
			# Get the new Agent
			#new_agent_scene = load("res://"+agent_name+".tscn")
			new_agent_scene = load(agent_tscn) #load("res://addons/BehavForGroups/Examples/"+agent_name+".tscn")
			new_agent_prototype = new_agent_scene.instantiate()
			# Find ALL its behaviors and put them in the new_agent_behaviors Array
			var biodyn_node:BehavForGroups = agent.get_parent().get_node("BehavForGroups")
			for b in biodyn_node.get_children(): # Get ALL the behaviors of BioDyn
				if b is Behavior and new_agent_prototype.is_in_group(b.agent_group):
					# Copy the current behavior to the new_agent_prototype
					var behav_clone:Behavior = b.duplicate(15) # Duplicate the Behavior recursively
					behav_clone.process_mode = Node.PROCESS_MODE_INHERIT # We can do it because its agent (proto) is NEVER in the scene tree
					new_agent_prototype.add_child(behav_clone) # Add the Behavior to the prototype agent

		# Add of an Agent to the Scene
		if root == null:
			root = get_tree().current_scene
		else:
			var nb_agents:int = root.get_child_count()
			if new_agent_scene != null and nb_agents < BehavForGroups.max_agents:
				var spawn = new_agent_prototype.duplicate()
				# Put and translate the spawn in the scene
				root.add_child(spawn)
				spawn.translate ( agent.transform.origin )
	return true
