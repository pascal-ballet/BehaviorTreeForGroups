## Return true when age reaches
## specified periodic values

@icon("condition.svg")
class_name IfAgeEqualsPeriodicValues
extends BehaviorTreeForGroups


## Size of each step
@export var period: int =0
@export var min_age: int =0
## Put -1 for infinite max age
@export var max_age: int = -1

func biodyn_process(agent)->bool:
	var age:int =agent.age
	if max_age == -1 :
		if age >= min_age :
			if (age-min_age)%period == 0 :
				return true
			else :
				return false
		else :
			return false
	elif age >= min_age and age <= max_age:
		if (age-min_age)%period == 0 :
			return true
		else :
			return false
	else :
		return false
