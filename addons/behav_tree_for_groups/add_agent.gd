## Dynamically add a new node/agent in the scene
## at the location of the current node/agent

@icon("action.svg")

class_name AddAgent
extends BehaviorTreeForGroups

#@export var agent_path:String = ""
@export_file("*.tscn") var agent_tscn: String

var root:Node = null
var new_agent_scene:Resource = null
var new_agent_behaviors:Array = []
var new_agent_prototype:Node = null

var btfg:BehaviorTreeForGroups = null

func biodyn_process(agent) -> bool:
	#if agent_tscn.ends_with("_in_fire.tscn") == true:
	#	print("TOUCH")

	if agent_tscn != "":
		# Initilize the Agent to clone
		if new_agent_scene == null:
			if root == null:
				root = get_tree().current_scene
			# Get the new Agent
			new_agent_scene = load(agent_tscn)
			new_agent_prototype = new_agent_scene.instantiate()
			# Find ALL its behaviors and put them in the new_agent_behaviors Array
			btfg = BTFG.btfg_root
			
			for b in btfg.get_children(): # Get ALL the behaviors of BehaviorTreeForGroups
				if b is Behavior and b.applies_on_agent(new_agent_prototype): #new_agent_prototype.is_in_group(b.on_group):
					# Copy the current behavior to the new_agent_prototype
					var behav_clone:Behavior = b.duplicate(15) # Duplicate the Behavior recursively
					behav_clone.process_mode = Node.PROCESS_MODE_INHERIT # We can do it because its agent (proto) is NEVER in the scene tree
					new_agent_prototype.add_child(behav_clone) # Add the Behavior to the prototype agent

		# Add of an Agent to the Scene
		var nb_agents:int = root.get_child_count()
		if new_agent_scene != null and nb_agents < BehaviorTreeForGroups.max_agents:
			var spawn = new_agent_prototype.duplicate()
			# Put and translate the spawn in the scene
			root.add_child(spawn)
			if agent.get("transform"):
				spawn.translate ( agent.transform.origin )
			else:
				spawn.translate ( agent.position )
	return true
