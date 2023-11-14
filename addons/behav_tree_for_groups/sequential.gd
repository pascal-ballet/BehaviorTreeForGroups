## Execute its children
## upto one of them fails
## (return false)

@icon("sequential.svg")
class_name Sequential
extends BehaviorTreeForGroups

## Activate / unactivate this sequence
@export var activated:bool = true

func biodyn_process(agent)->bool:
	# Sequential Node
	# Execute all its children, stops
	#	a) after the 1st Failed
	#	b) or after ALL children execution succeded
	# Return False if ONE of its children fail.
	# Returns True if all succeeded
	if activated == false:
		return false	
	for behav in self.get_children():
		var success = behav.biodyn_process(agent)
		if success == false:
			return false
	return true
