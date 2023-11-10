## BehavTreeForGroups
## ******************
## Node of a behavior
## MUST be a DIRECT child of the BehavTreeForGroups Node
## Works on one specific group
## Execute all its children, always
## like a Parallel Node

@icon("Behavior.svg")

class_name Behavior
extends BehavForGroups

@export var activated:bool = true
@export var on_group = ""

func _process(delta):
	biodyn_process(get_parent())
	
func biodyn_process(agent:Node)->bool:
	# The Behavior Node is a Parallel Node
	# It executes all its children, stops after ALL children execution
	# Returns True when at least ONE child returns True
	if activated == false:
		return false
	var overall_success:bool = false
	for behav in get_children():
		var success = behav.biodyn_process(agent)
		if success == true:
			overall_success = true
	
	return overall_success
