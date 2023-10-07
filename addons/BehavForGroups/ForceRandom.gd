@icon("Action.svg")
class_name ForceRandom
extends BehavForGroups

@export var fx:float = 1.0
@export var fy:float = 1.0
@export var fz:float = 1.0

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		var ffx:float = fx * (randf() - 0.5)
		var ffy:float = fy * (randf() - 0.5)
		var ffz:float = fz * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_central_impulse ( Vector3 (ffx, ffy, ffz) )
		return true
	
	if agent is RigidBody2D:
		var ffx:float = fx * (randf() - 0.5)
		var ffy:float = fy * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_central_impulse ( Vector2 (ffx, ffy) )
		return true
	
	return false
