## Root node of the BehavTreeForGroups plugin.
## Its DIRECT children MUST be Behavior Nodes

@icon("behavior_tree_for_groups.svg")

class_name BehaviorTreeForGroups
extends Node

## Max number of created agents
static var max_agents:int = 3000
##Number of agents
static var nb_agents:int = 0
## Current simulation step
static var simulation_step:int = 0

var init:bool = false

func put_all_behaviors():
	# The user will NOT execute BioDyn plugin
	if self.process_mode == Node.PROCESS_MODE_DISABLED:
		return

	# Put the behaviors INTO ALL agents according to their groups
	var root:Node = get_tree().current_scene
	for behav in get_children(): # Try to put the current behavior into the right agents
		if behav is Behavior and behav.process_mode != Node.PROCESS_MODE_DISABLED:
			for agt in root.get_children(): # Test the groups of ALL agents
				behav.process_mode = Node.PROCESS_MODE_DISABLED # It becomes Disabled in BioDyn behaviors (attached to no Agent)
				if agt.is_in_group(behav.on_group): # the behav is for the agt
					var behav_clone:Behavior = behav.duplicate(15)
					behav_clone.process_mode = Node.PROCESS_MODE_INHERIT
					agt.add_child(behav_clone) #we add the behavior into the agent

func _process(delta):
	if init == true: # All behaviors have been put into Agents
		simulation_step += 1
	else:
		put_all_behaviors()
		init = true
