## BehavTreeForGroups
## ******************
## Force the current agent
## to stay inside a 2D or 3D box

@tool
@icon("Action.svg")

class_name StayInBox
extends BehavForGroups

@export var min:Vector3 = Vector3(-5,-5,-5)
@export var max:Vector3 = Vector3( 5, 5, 5)
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
		if x < min.x:
			out_of_box = true
			if loop_x == true:
				new_x = max.x
			else:
				new_x = min.x
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.x = - (agent as RigidBody3D).linear_velocity.x
				
		if x > max.x:
			out_of_box = true
			if loop_x == true:
				new_x = min.x
			else:
				new_x = max.x
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.x = - (agent as RigidBody3D).linear_velocity.x

		# Y Axis
		if y < min.y:
			out_of_box = true
			if loop_y == true:
				new_y = max.y
			else:
				new_y = min.y
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.y = - (agent as RigidBody3D).linear_velocity.y
				
		if y > max.y:
			out_of_box = true
			if loop_y == true:
				new_y = min.y
			else:
				new_y = max.y
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.y = - (agent as RigidBody3D).linear_velocity.y

		# Z Axis
		if z < min.z:
			out_of_box = true
			if loop_z == true:
				new_z = max.z
			else:
				new_z = min.z
				if agent is RigidBody3D:
					(agent as RigidBody3D).linear_velocity.z = - (agent as RigidBody3D).linear_velocity.z
				
		if z > max.z:
			out_of_box = true
			if loop_z == true:
				new_z = min.z
			else:
				new_z = max.z
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
		if x < min.x:
			out_of_box = true
			if loop_x == true:
				new_x = max.x
			else:
				new_x = min.x
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.x = - (agent as RigidBody2D).linear_velocity.x
				
		if x > max.x:
			out_of_box = true
			if loop_x == true:
				new_x = min.x
			else:
				new_x = max.x
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.x = - (agent as RigidBody2D).linear_velocity.x

		# Y Axis
		if y < min.y:
			out_of_box = true
			if loop_y == true:
				new_y = max.y
			else:
				new_y = min.y
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.y = - (agent as RigidBody2D).linear_velocity.y
				
		if y > max.y:
			out_of_box = true
			if loop_y == true:
				new_y = min.y
			else:
				new_y = max.y
				if agent is RigidBody2D:
					(agent as RigidBody2D).linear_velocity.y = - (agent as RigidBody2D).linear_velocity.y

		if out_of_box == true:
			agent.global_transform.origin = Vector2(new_x,new_y)
#			agent.position.x = new_x
#			agent.position.y = new_y
		return true
		
	return false
