## Applies a random force to the current agent

@icon("action.svg")
class_name ForceRandom
extends BehaviorTreeForGroups

@export var F:Vector3 = Vector3(1,1,1)

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		var ffx:float = F.x * (randf() - 0.5)
		var ffy:float = F.y * (randf() - 0.5)
		var ffz:float = F.z * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_central_impulse ( Vector3 (ffx, ffy, ffz) )
		return true
	
	if agent is RigidBody2D:
		var ffx:float = F.x * (randf() - 0.5)
		var ffy:float = F.y * (randf() - 0.5)
		#call_deferred("agent.apply_central_force", Vector3 (ffx, ffy, ffz) )
		agent.apply_central_impulse ( Vector2 (ffx, ffy) )
		return true
	
	return false
