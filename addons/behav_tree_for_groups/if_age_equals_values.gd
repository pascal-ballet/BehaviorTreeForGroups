## Return true if the age equals
## one of the given values.

@icon("condition.svg")
class_name IfAgeEqualsValues
extends BehaviorTreeForGroups

@export var values:Array[int] = [10,20,25]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var age:int = agent.age
	if values.find(age, 0) >= 0 :
		return true
	else:
		return false
