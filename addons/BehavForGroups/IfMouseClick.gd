@icon("Condition.svg")
class_name IfMouseClick
extends BehavForGroups

@export_enum("Left:1","Right:2","Middle:3") var mouse_button = 1
@export var playerCamera:Camera3D
var btn:int = MOUSE_BUTTON_LEFT

func _ready():
	if mouse_button == 1:
		btn = MOUSE_BUTTON_LEFT
	if mouse_button == 2:
		btn = MOUSE_BUTTON_RIGHT
	if mouse_button == 3:
		btn = MOUSE_BUTTON_MIDDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func biodyn_process(agent)->bool:
	if Input.is_mouse_button_pressed(btn):
		if playerCamera == null:
				playerCamera = get_tree().root.find_child("Camera3D", true, false)
				if playerCamera == null:
					print("Camera3D not found")
					return false
		var spaceState = agent.get_world_3d().direct_space_state
		var mousePosition = agent.get_viewport().get_mouse_position()
		var raycastOrigin = playerCamera.project_ray_origin(mousePosition)
		var rayLength = 1000
		var raycastTarget = raycastOrigin + playerCamera.project_ray_normal(mousePosition) * rayLength
		var physicsRaycastQuery = PhysicsRayQueryParameters3D.create(raycastOrigin, raycastTarget)
		var raycastResult = spaceState.intersect_ray(physicsRaycastQuery)
		if raycastResult:
			if raycastResult.collider == agent:
				return true
	return false			
