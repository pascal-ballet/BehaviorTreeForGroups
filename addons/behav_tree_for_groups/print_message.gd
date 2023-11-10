## BehavTreeForGroups
## ******************
## Print a message into
## the Godot Output Window.

@icon("action.svg")
class_name PrintMessage
extends BehaviorTreeForGroups

## Message to print
@export var message:String = ""
## Data to print
@export var data:String = ""
## Blackboard reference to print
@export var reference:String = ""

func biodyn_process(agent)->bool:
	var msg:String = message
	if agent.has_meta(data):
		msg += ":"+data+" = " + agent.get_meta(data)
	var root:Node = get_tree().current_scene
	if root.has_meta(reference):
		msg += ":"+reference+" = " + root.get_meta(reference)
	
	print(msg)
	return true
