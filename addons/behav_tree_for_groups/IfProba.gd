## BehavTreeForGroups
## ******************
## Return true if a random float
## between 0 and 100 is inferior
##to a given float number

@icon("Condition.svg")
class_name IfProba
extends BehavForGroups

## Probability of success
@export var proba:float = 100

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	var rnd:float = randf()
	if rnd < proba/100.0:
		return true
	else:
		return false
