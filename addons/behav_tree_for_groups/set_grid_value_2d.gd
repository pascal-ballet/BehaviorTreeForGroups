## Set a float value inside a Grid2D
## at the location of the current agent

@icon("action_2d.svg")
class_name SetGridValue2D
extends BehaviorTreeForGroups

@export var on_grid_group:String = ""
@export var for_field:String = ""
@export var set_value:float = 0.5

var grids:Array = Array()

func _ready():
	grids = get_tree().get_nodes_in_group(on_grid_group)
	pass

func biodyn_process(agent)->bool:
	for grid in grids:
		# 2D
		if agent is Node2D and "values_t0" in grid:
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
					if grid.fields_dico.has(for_field) == true:
						grid.values_t0[p].values[grid.fields_dico[for_field]] = set_value
	return true
