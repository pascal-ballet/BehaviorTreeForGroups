@icon("Action.svg")
class_name StayInBox
extends BehavForGroups

@export var x_min:float = -5
@export var x_max:float = 5
@export var y_min:float = -5
@export var y_max:float = 5
@export var z_min:float = -5
@export var z_max:float = 5
@export var loop_x:bool = false
@export var loop_y:bool = false
@export var loop_z:bool = false

func biodyn_process(agent:Node) -> bool:
	if agent is Node3D:
		var x:float = agent.position.x
		var y:float = agent.position.y
		var z:float = agent.position.z
		
		var new_x:float = x
		var new_y:float = y
		var new_z:float = z

		var out_of_box = false

		# X Axis
		if x < x_min:
			out_of_box = true
			if loop_x == true:
				new_x = x_max
			else:
				new_x = x_min
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.x = - (agent as RigidBody3D).linear_velocity.x
				
		if x > x_max:
			out_of_box = true
			if loop_x == true:
				new_x = x_min
			else:
				new_x = x_max
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.x = - (agent as RigidBody3D).linear_velocity.x

		# Y Axis
		if y < y_min:
			out_of_box = true
			if loop_y == true:
				new_y = y_max
			else:
				new_y = y_min
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.y = - (agent as RigidBody3D).linear_velocity.y
				
		if y > y_max:
			out_of_box = true
			if loop_y == true:
				new_y = y_min
			else:
				new_y = y_max
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.y = - (agent as RigidBody3D).linear_velocity.y

		# Z Axis
		if z < z_min:
			out_of_box = true
			if loop_z == true:
				new_z = z_max
			else:
				new_z = z_min
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.z = - (agent as RigidBody3D).linear_velocity.z
				
		if z > z_max:
			out_of_box = true
			if loop_z == true:
				new_z = z_min
			else:
				new_z = z_max
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.z = - (agent as RigidBody3D).linear_velocity.z

		if out_of_box == true:
			#agent.position = Vector3(new_x,new_y,new_z)
			agent.global_transform.origin = Vector3(new_x,new_y,new_z)
		return true

	if agent is Node2D:
		var x:float = agent.position.x
		var y:float = agent.position.y
		
		var new_x:float = x
		var new_y:float = y

		var out_of_box = false

		# X Axis
		if x < x_min:
			out_of_box = true
			if loop_x == true:
				new_x = x_max
			else:
				new_x = x_min
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.x = - (agent as RigidBody2D).linear_velocity.x
				
		if x > x_max:
			out_of_box = true
			if loop_x == true:
				new_x = x_min
			else:
				new_x = x_max
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.x = - (agent as RigidBody2D).linear_velocity.x

		# Y Axis
		if y < y_min:
			out_of_box = true
			if loop_y == true:
				new_y = y_max
			else:
				new_y = y_min
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.y = - (agent as RigidBody2D).linear_velocity.y
				
		if y > y_max:
			out_of_box = true
			if loop_y == true:
				new_y = y_min
			else:
				new_y = y_max
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.y = - (agent as RigidBody2D).linear_velocity.y

		if out_of_box == true:
			agent.global_transform.origin = Vector2(new_x,new_y)
#			agent.position.x = new_x
#			agent.position.y = new_y
		return true
		
	return false
