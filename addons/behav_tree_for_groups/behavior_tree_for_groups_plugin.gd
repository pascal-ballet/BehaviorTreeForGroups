## BehaviorTreeForGroups
## ******************
## Editor plugin configuration

@tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	# Main Node
	add_custom_type("BehaviorTreeForGroups", "Node",\
			preload("behavior_tree_for_groups.gd"),preload("behavior_tree_for_groups.svg"))
	# Other Nodes (alphabetic order)
	add_custom_type("AddAgent", "BehaviorTreeForGroups",\
			preload("add_agent.gd"),preload("action.svg"))
	add_custom_type("AddAgentAtPos2D", "BehaviorTreeForGroups",\
			preload("add_agent_at_pos_2d.gd"),preload("action_2d.svg"))
	add_custom_type("AddAgentAtPos3D", "BehaviorTreeForGroups",\
			preload("add_agent_at_pos_3d.gd"),preload("action_3d.svg"))
	add_custom_type("AddSpringOnContact", "BehaviorTreeForGroups",\
			preload("add_spring_on_contact.gd"),preload("action.svg"))
	add_custom_type("Behavior", "BehaviorTreeForGroups",\
			preload("behavior.gd"),preload("behavior.svg"))
	add_custom_type("ChangeColor", "BehaviorTreeForGroups",\
			preload("change_color.gd"),preload("action.svg"))
	add_custom_type("ChangeColorRandom", "BehaviorTreeForGroups",\
			preload("change_color_random.gd"),preload("action.svg"))
	add_custom_type("CloneAgent", "BehaviorTreeForGroups",\
			preload("clone_agent.gd"),preload("action.svg"))
	add_custom_type("CloneAgentAtPos2D", "BehaviorTreeForGroups",\
			preload("clone_agent_at_pos_2d.gd"),preload("action_2d.svg"))
	add_custom_type("CloneAgentAtPos3D", "BehaviorTreeForGroups",\
			preload("clone_agent_at_pos_3d.gd"),preload("action_3d.svg"))
	add_custom_type("DataPlus", "BehaviorTreeForGroups",\
			preload("data_plus.gd"),preload("action.svg"))
	add_custom_type("DataSet", "BehaviorTreeForGroups",\
			preload("data_set.gd"),preload("action.svg"))
	add_custom_type("Delete", "BehaviorTreeForGroups",\
			preload("delete.gd"),preload("action.svg"))
	add_custom_type("Fallback", "BehaviorTreeForGroups",\
			preload("fallback.gd"),preload("fallback.svg"))
	add_custom_type("ForceAngularZ", "BehaviorTreeForGroups",\
			preload("force_angular_z.gd"),preload("action.svg"))
	add_custom_type("ForceAngularZ", "BehaviorTreeForGroups",\
			preload("force_angular_z.gd"),preload("action.svg"))
	add_custom_type("ForceForward", "BehaviorTreeForGroups",\
			preload("force_forward.gd"),preload("action.svg"))
	add_custom_type("ForceGlobal", "BehaviorTreeForGroups",\
			preload("force_global.gd"),preload("action.svg"))
	add_custom_type("ForceRadial", "BehaviorTreeForGroups",\
			preload("force_radial.gd"),preload("action.svg"))
	add_custom_type("ForceRandom", "BehaviorTreeForGroups",\
			preload("force_random.gd"),preload("action.svg"))
	add_custom_type("ForceToGridValue", "BehaviorTreeForGroups",\
			preload("force_to_grid_value.gd"),preload("action.svg"))
	add_custom_type("GlobalDataPlus", "BehaviorTreeForGroups",\
			preload("global_data_plus.gd"),preload("action.svg"))
	add_custom_type("GlobalDataSet", "BehaviorTreeForGroups",\
			preload("global_data_set.gd"),preload("action.svg"))
	add_custom_type("IfAgeBetween", "BehaviorTreeForGroups",\
			preload("if_age_between.gd"),preload("condition.svg"))
	add_custom_type("IfAgeEquals", "BehaviorTreeForGroups",\
			preload("if_age_equals.gd"),preload("condition.svg"))
	add_custom_type("IfAgeEqualsValues", "BehaviorTreeForGroups",\
			preload("if_age_equals_values.gd"),preload("condition.svg"))
	add_custom_type("IfAgeEqualsPeriodicValues", "BehaviorTreeForGroups",\
			preload("if_age_equals_periodic_values.gd"),preload("condition.svg"))
	add_custom_type("IfAgeInf", "BehaviorTreeForGroups",\
			preload("if_age_inf.gd"),preload("condition.svg"))
	add_custom_type("IfAgeSup", "BehaviorTreeForGroups",\
			preload("if_age_sup.gd"),preload("condition.svg"))
	add_custom_type("IfCollision", "BehaviorTreeForGroups",\
			preload("if_collision.gd"),preload("condition.svg"))
	add_custom_type("IfDataBetween", "BehaviorTreeForGroups",\
			preload("if_data_between.gd"),preload("condition.svg"))
	add_custom_type("IfDataEquals", "BehaviorTreeForGroups",\
			preload("if_data_equals.gd"),preload("condition.svg"))
	add_custom_type("IfDataEqualsPeriodicValues", "BehaviorTreeForGroups",\
			preload("if_data_equals_periodic_values.gd"),preload("condition.svg"))
	add_custom_type("IfDataEqualsValues", "BehaviorTreeForGroups",\
			preload("if_data_equals_values.gd"),preload("condition.svg"))
	add_custom_type("IfDataInf", "BehaviorTreeForGroups",\
			preload("if_data_inf.gd"),preload("condition.svg"))
	add_custom_type("IfDataSup", "BehaviorTreeForGroups",\
			preload("if_data_sup.gd"),preload("condition.svg"))
	add_custom_type("IfGlobalDataBetween", "BehaviorTreeForGroups",\
			preload("if_global_data_between.gd"),preload("condition.svg"))
	add_custom_type("IfGlobalDataEquals", "BehaviorTreeForGroups",\
			preload("if_global_data_equals.gd"),preload("condition.svg"))
	add_custom_type("IfGlobalDataInf", "BehaviorTreeForGroups",\
			preload("if_global_data_inf.gd"),preload("condition.svg"))
	add_custom_type("IfGlobalDataSup", "BehaviorTreeForGroups",\
			preload("if_global_data_sup.gd"),preload("condition.svg"))
	add_custom_type("IfGrid2DValueInf", "BehaviorTreeForGroups",\
			preload("if_grid_2d_value_inf.gd"),preload("condition_2d.svg"))
	add_custom_type("IfGrid2DValueSup", "BehaviorTreeForGroups",\
			preload("if_grid_2d_value_sup.gd"),preload("condition_2d.svg"))
	add_custom_type("IfInBox", "BehaviorTreeForGroups",\
			preload("if_in_box.gd"),preload("condition.svg"))
	add_custom_type("IfMouseClick", "BehaviorTreeForGroups",\
			preload("if_mouse_click.gd"),preload("condition.svg"))
	add_custom_type("IfNoContact", "BehaviorTreeForGroups",\
			preload("if_no_contact.gd"),preload("condition.svg"))
	add_custom_type("IfNoContactWith", "BehaviorTreeForGroups",\
			preload("if_no_contact_with.gd"),preload("condition.svg"))
	add_custom_type("IfProba", "BehaviorTreeForGroups",\
			preload("if_proba.gd"),preload("condition.svg"))
	add_custom_type("IfStateEquals", "BehaviorTreeForGroups",\
			preload("if_state_equals.gd"),preload("condition.svg"))
	add_custom_type("IfStepBetween", "BehaviorTreeForGroups",\
			preload("if_step_between.gd"),preload("condition.svg"))
	add_custom_type("IfTimeBetween", "BehaviorTreeForGroups",\
			preload("if_time_between.gd"),preload("condition.svg"))
	add_custom_type("IfTimeInf", "BehaviorTreeForGroups",\
			preload("if_time_inf.gd"),preload("condition.svg"))
	add_custom_type("IfTimeSup", "BehaviorTreeForGroups",\
			preload("if_time_sup.gd"),preload("condition.svg"))
	add_custom_type("NewAgent2D", "BehaviorTreeForGroups",\
			preload("new_agent_2d.gd"),preload("action_2d.svg"))
	add_custom_type("NewAgent3D", "BehaviorTreeForGroups",\
			preload("new_agent_3d.gd"),preload("action_3d.svg"))
	add_custom_type("NewGrid2D", "BehaviorTreeForGroups",\
			preload("new_grid_2d.gd"),preload("action_2d.svg"))
	add_custom_type("Parallel", "BehaviorTreeForGroups",\
			preload("parallel.gd"),preload("parallel.svg"))
	add_custom_type("PrintMessage", "BehaviorTreeForGroups",\
			preload("print_message.gd"),preload("parallel.svg"))
	add_custom_type("Sequential", "BehaviorTreeForGroups",\
			preload("sequential.gd"),preload("sequential.svg"))
	add_custom_type("SetAge", "BehaviorTreeForGroups",\
			preload("set_age.gd"),preload("action_2d.svg"))
	add_custom_type("SetGridValue2D", "BehaviorTreeForGroups",\
			preload("set_grid_value_2d.gd"),preload("action_2d.svg"))
	add_custom_type("SetState", "BehaviorTreeForGroups",\
			preload("set_state.gd"),preload("action.svg"))
	add_custom_type("StayInBox", "BehaviorTreeForGroups",\
			preload("stay_in_box.gd"),preload("action.svg"))
	add_custom_type("TorqueGlobal", "BehaviorTreeForGroups",\
			preload("torque_global.gd"),preload("action.svg"))
	add_custom_type("TorqueRandom", "BehaviorTreeForGroups",\
			preload("torque_random.gd"),preload("action.svg"))
	add_custom_type("TranslateRandom", "BehaviorTreeForGroups",\
			preload("translate_random.gd"),preload("action.svg"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Main Node
	remove_custom_type("BehaviorTreeForGroups")
	# Other Nodes (alphabetic order)
	remove_custom_type("AddAgent")
	remove_custom_type("AddAgentAtPos2D")
	remove_custom_type("AddAgentAtPos3D")
	remove_custom_type("AddSpringOnContact")
	remove_custom_type("Behavior")
	remove_custom_type("ChangeColor")
	remove_custom_type("ChangeColorRandom")
	remove_custom_type("CloneAgent")
	remove_custom_type("CloneAgentAtPos2D")
	remove_custom_type("CloneAgentAtPos3D")
	remove_custom_type("DataPlus")
	remove_custom_type("DataSet")
	remove_custom_type("Delete")
	remove_custom_type("Fallback")
	remove_custom_type("ForceAngularZ")
	remove_custom_type("ForceAngularZ")
	remove_custom_type("ForceForward")
	remove_custom_type("ForceGlobal")
	remove_custom_type("ForceRadial")
	remove_custom_type("ForceRandom")
	remove_custom_type("ForceToGridValue")
	remove_custom_type("GlobalDataPlus")
	remove_custom_type("GlobalDataSet")
	remove_custom_type("IfAgeBetween")
	remove_custom_type("IfAgeEquals")
	remove_custom_type("IfAgeEqualsValues")
	remove_custom_type("IfAgeEqualsPeriodicValues")
	remove_custom_type("IfAgeInf")
	remove_custom_type("IfAgeSup")
	remove_custom_type("IfCollision")
	remove_custom_type("IfDataBetween")
	remove_custom_type("IfDataEquals")
	remove_custom_type("IfDataEqualsPeriodicValues")
	remove_custom_type("IfDataEqualsValues")
	remove_custom_type("IfDataInf")
	remove_custom_type("IfDataSup")
	remove_custom_type("IfGlobalDataBetween")
	remove_custom_type("IfGlobalDataEquals")
	remove_custom_type("IfGlobalDataInf")
	remove_custom_type("IfGlobalDataSup")
	remove_custom_type("IfGrid2DValueInf")
	remove_custom_type("IfGrid2DValueSup")
	remove_custom_type("IfInBox")
	remove_custom_type("IfMouseClick")
	remove_custom_type("IfNoContact")
	remove_custom_type("IfNoContactWith")
	remove_custom_type("IfProba")
	remove_custom_type("IfStateEquals")
	remove_custom_type("IfStepBetween")
	remove_custom_type("IfTimeBetween")
	remove_custom_type("IfTimeInf")
	remove_custom_type("IfTimeSup")
	remove_custom_type("NewAgent2D")
	remove_custom_type("NewAgent3D")
	remove_custom_type("NewGrid2D")
	remove_custom_type("Parallel")
	remove_custom_type("PrintMessage")
	remove_custom_type("Sequential")
	remove_custom_type("SetAge")
	remove_custom_type("SetGridValue2D")
	remove_custom_type("SetState")
	remove_custom_type("StayInBox")
	remove_custom_type("TorqueGlobal")
	remove_custom_type("TorqueRandom")
	remove_custom_type("TranslateRandom")
