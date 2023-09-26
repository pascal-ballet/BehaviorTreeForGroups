@icon("Action.svg")
class_name TranslateRandom
extends BehavForGroups

@export var dx:float = 1.0
@export var dy:float = 1.0
@export var dz:float = 1.0

func biodyn_process(agent)->bool:
	var ddx:float = randf()*dx - dx / 2.0
	var ddy:float = randf()*dy - dy / 2.0
	var ddz:float = randf()*dz - dz / 2.0
	agent.translate ( Vector3 (ddx, ddy, ddz) )
	return true
