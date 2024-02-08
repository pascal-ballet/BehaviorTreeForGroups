## Change the color of a node/agent randomly.

@icon("action.svg")
class_name ChangeColorRandom
extends BehaviorTreeForGroups


func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		# New material
		var mat:StandardMaterial3D = StandardMaterial3D.new()
		mat.albedo_color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1))
		# Put the new material
		var msh:MeshInstance3D     = agent.get_node("MeshInstance3D")
		msh.material_override = mat
		return true
		
	if agent is RigidBody2D:
		var poly:Polygon2D = agent.get_node("Polygon2D")
		poly.color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1))
		return true

	return false
