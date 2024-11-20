## Applies a force to the current agent
## toward the value the agent has to reach
## inside a Grid of values

@icon("action.svg")
class_name ForceToGridValue
extends BehaviorTreeForGroups

@export var on_grid_group:String = ""
@export var for_field:String = ""
@export var target_value:float = 0
@export var force:float = 0

var grids:Array = Array()

func _ready():
	grids = get_tree().get_nodes_in_group(on_grid_group)
	pass

func biodyn_process(agent)->bool:
	for grid in grids:
		# 2D
		var F:Vector2 = Vector2(0,0)
		if agent is RigidBody2D and "values_t0" in grid:
			var ax:float = agent.position.x
			var ay:float = agent.position.y
			var gx_min:float = grid.position.x
			var gx_max:float = gx_min+grid.size.x
			var gy_min:float = grid.position.y
			var gy_max:float = gy_min+grid.size.y
			if ax >= gx_min && ax < gx_max:
				if ay >= gy_min && ay < gy_max:
					var px:int = ((ax - gx_min) / grid.size.x) * grid.SX
					var py:int = ((ay - gy_min) / grid.size.y) * grid.SY
					var p:int = px+py*grid.SX
					var fx:float = 0
					var fy:float = 0
					if grid.fields_dico.has(for_field) == true:
						var p0:float = grid.values_t0[(p+1)%(grid.SX*grid.SY)].values[grid.fields_dico[for_field]]
						var p1:float = grid.values_t0[(p-grid.SX+grid.SX*grid.SY)%(grid.SX*grid.SY)].values[grid.fields_dico[for_field]]
						var p2:float = grid.values_t0[(p-1+grid.SX*grid.SY)%(grid.SX*grid.SY)].values[grid.fields_dico[for_field]]
						var p3:float = grid.values_t0[(p+grid.SX)%(grid.SX*grid.SY)].values[grid.fields_dico[for_field]]
						if grid.values_t0[p].values[grid.fields_dico[for_field]] >= target_value:
							# Go to the lowest value arround
							if p0 <= p1 && p0 <= p2 && p0 <= p3:
								fx = force
							elif p1 <= p2 && p1 <= p3:
								fy = -force
							elif p2 <= p3:
								fx = -force
							else:
								fy = force
						if grid.values_t0[p].values[grid.fields_dico[for_field]] < target_value:
							# Go to the highest value arround
							if p0 >= p1 && p0 >= p2 && p0 >= p3:
								fx = force
							elif p1 >= p2 && p1 >= p3:
								fy = -force
							elif p2 >= p3:
								fx = -force
							else:
								fy = force
					F = F + Vector2(fx,fy)
				agent.apply_impulse(F)
	return true
