@icon("Action.svg")
class_name PrintMessage
extends BehavForGroups

@export var message:String = ""
@export var data:String = ""
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
