@icon("Action.svg")
class_name SetGridValue
extends BehavForGroups

@export var on_grid_group:String = ""
@export var set_value:float = 0.5

var grids:Array = Array()

func _ready():
	grids = get_tree().get_nodes_in_group(on_grid_group)
	pass

func biodyn_process(agent)->bool:
	for grid in grids:
		# 2D
		if agent is Node2D:
			var ax = agent.transform.origin.x
			var ay = agent.transform.origin.y
			var gx_min:float = grid.transform.origin.x
			var gx_max:float = gx_min+grid.transform.scale.x
			var gy_min:float = grid.transform.origin.y
			var gy_max:float = gy_min+grid.transform.scale.y
			if ax >= gx_min && ax < gx_max:
				if ay >= gy_min && ay < gy_min:
					var px:int = ((ax - grid.transform.origin.x) / grid.transform.origin.scale.x) * grid.SX
					var py:int = ((ax - grid.transform.origin.y) / grid.transform.origin.scale.y) * grid.SY
					grid[px+py*grid.SX] = set_value
	return true
