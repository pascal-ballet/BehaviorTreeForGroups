## Return true if the agent's age
## is equal to the given integer number.

@icon("condition.svg")
class_name IfAgeEquals
extends BehaviorTreeForGroups

@export var age_equals:int = 0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var age:int = agent.age
	if age == age_equals :
		return true
	else:
		return false
