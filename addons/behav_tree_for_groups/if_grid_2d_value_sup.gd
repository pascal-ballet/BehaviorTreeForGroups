## Return true if an agent
## is inside a grid having a value
## superior to a float number

@icon("condition_2d.svg")
class_name IfGrid2DValueSup
extends BehaviorTreeForGroups

## Name of the Grid's group
## Value to test (in Magnitude: 1=1/10, 2=1/100, 3=1/1000, etc)
@export var is_sup_to:float = 0

var grids:Array = Array()

func _ready():
	for gp in self.get_groups():
		var sous_grids = get_tree().get_nodes_in_group(gp)
		for sg in sous_grids:
			grids.push_back(sg)

func biodyn_process(agent)->bool:
	var cdt:bool = false
	for grid in grids:
		# 2D
		if agent is Node2D:
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
					var val:float = grid.values_t0[p]
					if val >= pow(10, -is_sup_to):
						cdt = true
	return cdt
