@tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	print_debug("Enter tree")
	# Root of Behavior Tree
	#add_custom_type("BioDyn", 		"Node",preload("BioDyn.gd"),null)
	
#	# Execution entry point Node (works like a Parallel Node)
	#add_custom_type("Behavior", 	"BioDyn",preload("Behavior.gd"),null)
#
#	# Control Nodes
#	add_custom_type("Parallel", 	"BioDyn",preload("res://addons/biodyn/Parallel.gd"),preload("res://addons/biodyn/Parallel.svg"))
#	add_custom_type("Sequential", 	"BioDyn",preload("res://addons/biodyn/Sequential.gd"),preload("res://addons/biodyn/Sequential.svg"))
#	add_custom_type("Fallback", 	"BioDyn",preload("res://addons/biodyn/Fallback.gd"),preload("res://addons/biodyn/Fallback.svg"))	
#
#	# Execution Nodes
#	# 1) Conditions Nodes
#	add_custom_type("Contact", 		"BioDyn",preload("res://addons/biodyn/Contact.gd"),preload("res://addons/biodyn/Condition.svg"))
#	add_custom_type("DataIsEqual", 	"BioDyn",preload("res://addons/biodyn/DataIsEqual.gd"),preload("res://addons/biodyn/Condition.svg"))
#	add_custom_type("DataIsInf", 	"BioDyn",preload("res://addons/biodyn/DataIsInf.gd"),preload("res://addons/biodyn/Condition.svg"))
#	add_custom_type("DataIsSup", 	"BioDyn",preload("res://addons/biodyn/DataIsSup.gd"),preload("res://addons/biodyn/Condition.svg"))
#	add_custom_type("Proba", 		"BioDyn",preload("res://addons/biodyn/Proba.gd"),preload("res://addons/biodyn/Condition.svg"))
#	# 2) Actions Nodes LangevinForce
#	add_custom_type("AddAgent", 	"BioDyn",preload("res://addons/biodyn/AddAgent.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("DataAdd", 		"BioDyn",preload("res://addons/biodyn/DataAdd.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("DataSet", 		"BioDyn",preload("res://addons/biodyn/DataSet.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("Death", 		"BioDyn",preload("res://addons/biodyn/Death.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("GlobalForce", 	"BioDyn",preload("res://addons/biodyn/GlobalForce.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("GlobalTorque", "BioDyn",preload("res://addons/biodyn/GlobalTorque.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("ForwardForce", "BioDyn",preload("res://addons/biodyn/ForwardForce.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("RandomForce", 	"BioDyn",preload("res://addons/biodyn/RandomForce.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("RandomTorque", "BioDyn",preload("res://addons/biodyn/RandomTorque.gd"),preload("res://addons/biodyn/Action.svg"))
#	add_custom_type("RandomWalk", 	"BioDyn",preload("res://addons/biodyn/RandomWalk.gd"),preload("res://addons/biodyn/Action.svg"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	print_debug("Exit tree")
	#remove_custom_type("BioDyn")
	
	#remove_custom_type("Behavior")
#
#	remove_custom_type("Parallel")
#	remove_custom_type("Sequential")
#	remove_custom_type("Fallback")
#
#	remove_custom_type("Contact")
#	remove_custom_type("DataIsEqual")
#	remove_custom_type("DataIsInf")
#	remove_custom_type("DataIsSup")
#	remove_custom_type("Proba")
#
#	remove_custom_type("AddAgent")
#	remove_custom_type("DataAdd")
#	remove_custom_type("DataSet")
#	remove_custom_type("Death")
#	remove_custom_type("GlobalForce")
#	remove_custom_type("GlobalTorque")
#	remove_custom_type("ForwardForce")
#	remove_custom_type("RandomForce")
#	remove_custom_type("RandomTorque")
#	remove_custom_type("RandomWalk")
