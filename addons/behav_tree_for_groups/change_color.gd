## Change the color of a node/agent.

@icon("action.svg")
class_name ChangeColor
extends BehaviorTreeForGroups

@export var color:Color = Color.CHARTREUSE

func biodyn_process(agent)->bool:
	if agent is RigidBody3D:
		# New material
		var mat:StandardMaterial3D = StandardMaterial3D.new()
		mat.albedo_color = color
		# Put the new material
		var msh:MeshInstance3D     = agent.get_node("MeshInstance3D")
		msh.material_override = mat
		return true
		
	if agent is RigidBody2D:
		var poly:Polygon2D = agent.get_node("Polygon2D")
		poly.color = color
		return true

	return false
