@icon("Action.svg")
class_name AddSpringOnContact
extends BehavForGroups

## Group to contact with
@export var with_group:String = ""
## State of the group
@export var in_state:int = -1
## Break length of the spring
@export var spring_max_length:float = 30
## Spring stifness
@export var spring_stifness:float = 1
## Length at rest of the spring (-1 is the length when created)
@export var spring_length_at_rest:float = -1
## Max links for the current agent
@export var max_links : int = 1

var lst_cells_linked: Array = []

func biodyn_process(agent)->bool:

	if lst_cells_linked.size() / 2 < max_links:
		var bodies = agent.get_colliding_bodies()
		if bodies.size() > 0:
			for b in bodies:
				if b.is_in_group(with_group) && (!("state" in b) || ( b.state == in_state || in_state == -1)):
					if lst_cells_linked.has([agent, b]) == false: # evite 2x le meme spring
						if agent is RigidBody3D:
							cell_cell_spring3D(agent, b) # on les relient par un Spring
						if agent is RigidBody2D:
							cell_cell_spring2D(agent, b) # on les relient par un Spring
						# Store the link to avoid multiple ones AND more than max_links
						lst_cells_linked.append([agent, b])
						lst_cells_linked.append([b, agent])
						return true
	return false


func cell_cell_spring2D(body1:RigidBody2D, body2:RigidBody2D) -> Array:
	var length_at_rest:float = spring_length_at_rest
	if spring_length_at_rest == -1:
		length_at_rest = (body2.transform.origin-body1.transform.origin).length()
	# Create a new script with embedded expression
	var scrip:GDScript = GDScript.new()
	# Define source code needed for evaluation (extends Reference by default)
	scrip.source_code = """
extends Node
var _node_a = null
var _node_b = null

func _process(_delta):
	if _node_a == null || _node_b == null:
		print("Spring Removed")
		queue_free()
	else:
		var pos_a:Vector2 = _node_a.transform.origin
		var pos_b:Vector2 = _node_b.transform.origin
		var d:float = pos_a.distance_to(pos_b)
		if d > """+str(spring_max_length)+""":
			queue_free()
		else:
			var i:float = d - """ + str(length_at_rest) + """
			var dirA:Vector2 = (pos_b - pos_a).normalized()*"""+str(spring_stifness)+"""
			var dirB:Vector2 = -dirA
			_node_a.apply_impulse(i*dirA)
			_node_b.apply_impulse(i*dirB)
"""
	# Must reload the script with changed source code before putting it
	# to the node
	scrip.reload()

	# Need to create an instance of the script to call its methods
	var spring = Node.new()
	spring.name = "Spring"
	spring.set_script(scrip)
	
	spring._node_a = body1
	spring._node_b = body2
	
	body1.get_parent().add_child(spring)
	
	#print( str(body1.get_name() , " with " , body2.get_name() ) )
	
	return [body1, body2]


func cell_cell_spring3D(body1:RigidBody3D, body2:RigidBody3D) -> Array:
	#print( str(body1.get_name() , " with " , body2.get_name() ) )
	# Creation d'un ressort entre les 2 RigidBodies
	var jt:Generic6DOFJoint3D = Generic6DOFJoint3D.new()

	# USELESS LINEAR SPRING DATA
#	jt.set_flag_x (jt.FLAG_ENABLE_LINEAR_LIMIT, 			true	)
#	jt.set_flag_x (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)
#
#	jt.set_flag_y (jt.FLAG_ENABLE_LINEAR_LIMIT, 			true	)
#	jt.set_flag_y (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)
#
#	jt.set_flag_z (jt.FLAG_ENABLE_LINEAR_LIMIT, 			true	)
#	jt.set_flag_z (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)

	# LINEAR SPRING DATA
#	jt.set_flag_x (jt.FLAG_ENABLE_LINEAR_SPRING, 			false	)
#	jt.set_param_x(jt.PARAM_LINEAR_SPRING_STIFFNESS,		0.1		)
#	jt.set_param_x(jt.PARAM_LINEAR_DAMPING, 				0.1		)
	#jt.set_param_x(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)

#	jt.set_flag_y (jt.FLAG_ENABLE_LINEAR_SPRING, 			false	)
#	jt.set_param_y(jt.PARAM_LINEAR_SPRING_STIFFNESS,		0.1		)
#	jt.set_param_y(jt.PARAM_LINEAR_DAMPING, 				0.1		)
	#jt.set_param_y(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)

#	jt.set_flag_z (jt.FLAG_ENABLE_LINEAR_SPRING, 			false	)
#	jt.set_param_z(jt.PARAM_LINEAR_SPRING_STIFFNESS,		0.1		)
#	jt.set_param_z(jt.PARAM_LINEAR_DAMPING, 				0.1		)
	#jt.set_param_z(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)

	# ANGULAR SPRING
	jt.set_flag_x (jt.FLAG_ENABLE_ANGULAR_SPRING, 			false	)
	jt.set_param_x(jt.PARAM_ANGULAR_SPRING_STIFFNESS,		1.0		)
	jt.set_param_x(jt.PARAM_ANGULAR_DAMPING, 				1.0		)
	jt.set_param_x(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)

	jt.set_flag_y (jt.FLAG_ENABLE_ANGULAR_SPRING, 			false	)
	jt.set_param_y(jt.PARAM_ANGULAR_SPRING_STIFFNESS,		1.0		)
	jt.set_param_y(jt.PARAM_ANGULAR_DAMPING, 				1.0		)
	jt.set_param_y(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)

	jt.set_flag_z (jt.FLAG_ENABLE_ANGULAR_SPRING, 			false	)
	jt.set_param_z(jt.PARAM_ANGULAR_SPRING_STIFFNESS,		1.0		)
	jt.set_param_z(jt.PARAM_ANGULAR_DAMPING, 				1.0		)
	jt.set_param_z(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)
	
	jt.set_exclude_nodes_from_collision(false)
	# Ajout de ce ressort sur les 2 RigidBodies
	jt.set_node_a(body1.get_path())
	jt.set_node_b(body2.get_path())
	# Position du spring
	jt.transform.origin = (body1.transform.origin + body2.transform.origin) * 0.5
	# Ajout de son script d'affichage
	jt.script = load("res://addons/BehavForGroups/BreakableSpring.gd")
	# Ajout de son script de cassage
	#jt.script = load("res://BreakableSpring.gd")
	#print("node a = " + self.get_path())
	#print("node b = " + body.get_path())
	# Ajout du Ressort dans la scène (sinon inactif)
	body1.get_parent().add_child(jt)
	return [body1, body2]


#
################################################################################################
## PARAMETERS OF CELLS & SPRINGS
################################################################################################
## CELLS
##   - Damping intensity (see frottement)
##   - Agitation (see Langevin Force)
##   - Radius
## SPRINGS
##   - Length of rupture (see Spring break)
##   - Stiffness of Spring (liaison more or less elastic)
################################################################################################
#extends Node3D
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#func _process(delta:float):
#	var str_info:String
#	str_info = str("Nb Cells=" , $Cells.get_children().size())
#	str_info = str(str_info , "Nb Springs=" , $Springs.get_children().size())
#	$Infos/Viewport/Label.set_text (str_info)
#	pass
#
#var _step:int=0
#var lst_cells_linked: Array = []
################################################################################################
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta:float):
#	#print(str("******* STEP = " , _step , " ************"))
#	var lst_cells:	Array = $Cells.get_children()
#	var lst_springs:	Array = $Springs.get_children()
#	# ############################
#	# Parcours des Springs à supprimer
#	# ############################
#	for s in lst_springs:
#		breakSpring(s)
#
#	# ############################
#	# Parcours des Springs à créer
#	# ############################
#
#	for cell1 in lst_cells:
#		#print(str("    >>>> Current CELL = " , cell1.get_name()))
#		var bodies : Array = cell1.get_colliding_bodies () # toutes les collisions (reglé à 1 MAX)
#		var nbColl : int = bodies.size() # nb de collisions
#		if nbColl > 0: # il y a bien une collision
#			#print( str("collisions nb = ", bodies.size() ) )
#			var cell2 : RigidDynamicBody3D = bodies[0] # on recupere l'autre cell
#			if lst_cells_linked.has([cell2, cell1]) == false: # evite 2x le meme spring
#				#print( str("        ---- NEW Spring entre ", cell1.get_name(), " et ", cell2.get_name() ) )
#				cell_cell_spring(cell1, cell2) # on les relient par un Spring
#				lst_cells_linked.append([cell1, cell2])
#				lst_cells_linked.append([cell2, cell1])
#
#	# ############################
#	# Frottement (régime fluide)
#	# ############################
#	for cell in lst_cells:
#		(cell as RigidDynamicBody3D).linear_velocity = (cell as RigidDynamicBody3D).linear_velocity * 0.95
#		(cell as RigidDynamicBody3D).angular_velocity = (cell as RigidDynamicBody3D).angular_velocity * 0.95	
#
#	# ############################
#	# Force langevin
#	# ############################
##	for cell in lst_cells:
##		var a:	float = randf_range(-3.14159, 3.14159)
##		var i:	float = randf_range(0.0, 1.0)
##		cell.apply_central_impulse(Vector3(i*cos(a),0,i*sin(a)))
#
#	# ############################
#	# Force rotation
#	# ############################
##	for cell in lst_cells:
##		var angle:float = atan2(cell.transform.origin.y, cell.transform.origin.x);
##		var fx:	float = cos(angle) / 10.0
##		var fz:	float = sin(angle) / 10.0
##		cell.apply_central_impulse(Vector3(-fz,0,fx))
#
#	# ############################
#	# Division Cellulaire
#	# ############################
##	for cell in lst_cells:
##		var alea:	float = randf_range(0.0, 1.0)
##		if(alea < 0.0035):
##			$Cells.add_child(cell.duplicate())
#
#	# ############################
#	# Mort Cellulaire
#	# ############################
##	for cell in lst_cells:
##		var alea:	float = randf_range(0.0, 1.0)
##		if(alea < 0.002):
##			cell.call_deferred("free")
#
#
#	_step = _step+1
#
################################################################################################
## Ajout d'un ressort entre 2 RigidBodies (cf onglet Node => Body entered)
#func testCollisions(cell1 : RigidDynamicBody3D):
#	var bodies : Array = cell1.get_colliding_bodies () # toutes les collisions (à priori reglé à 1 MAX)
#	var nbColl : int = bodies.size() # nb de collisions
#	if nbColl > 0: # il y a bien une collision
#		#print( str("collisions nb = ", bodies.size() ) )
#		var cell2 : RigidDynamicBody3D = bodies[0] # on recupere l'autre cell
#		cell_cell_spring(cell1, cell2) # on les relient par un Spring
#
################################################################################################
#func cell_cell_spring(body1:RigidDynamicBody3D, body2:RigidDynamicBody3D) -> Array:
#	print( str(body1.get_name() , " with " , body2.get_name() ) )
#	# Creation d'un ressort entre les 2 RigidBodies
#	var jt:Generic6DOFJoint3D = Generic6DOFJoint3D.new()
#
#	# USELESS LINEAR SPRING DATA
#	jt.set_flag_x (jt.FLAG_ENABLE_LINEAR_LIMIT, 			false	)
#	jt.set_flag_x (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)
#
#	jt.set_flag_y (jt.FLAG_ENABLE_LINEAR_LIMIT, 			false	)
#	jt.set_flag_y (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)
#
#	jt.set_flag_z (jt.FLAG_ENABLE_LINEAR_LIMIT, 			false	)
#	jt.set_flag_z (jt.FLAG_ENABLE_ANGULAR_LIMIT, 			false	)
#
#	# LINEAR SPRING DATA
#	jt.set_flag_x (jt.FLAG_ENABLE_LINEAR_SPRING, 			true	)
#	jt.set_param_x(jt.PARAM_LINEAR_SPRING_STIFFNESS,		10000.0		)
#	jt.set_param_x(jt.PARAM_LINEAR_DAMPING, 				1.0		)
#	#jt.set_param_x(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)
#
#	jt.set_flag_z (jt.FLAG_ENABLE_LINEAR_SPRING, 			true	)
#	jt.set_param_z(jt.PARAM_LINEAR_SPRING_STIFFNESS,		10000.0		)
#	jt.set_param_z(jt.PARAM_LINEAR_DAMPING, 				1.0		)
#	#jt.set_param_z(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)
#
#	# ANGULAR SPRING
#	jt.set_flag_y (jt.FLAG_ENABLE_ANGULAR_SPRING, 			true	)
#	jt.set_param_y(jt.PARAM_ANGULAR_SPRING_STIFFNESS,		1.0		)
#	jt.set_param_y(jt.PARAM_ANGULAR_DAMPING, 				1.0		)
#	#jt.set_param_y(jt.PARAM_LINEAR_SPRING_EQUILIBRIUM_POINT, 0		)
#
#	jt.set_exclude_nodes_from_collision(false)
#	# Ajout de ce ressort sur les 2 RigidBodies
#	jt.set_node_a(body1.get_path())
#	jt.set_node_b(body2.get_path())
#	# Position du spring
#	jt.transform.origin = (body1.transform.origin + body2.transform.origin) * 0.5
#	# Ajout de son script de cassage
#	#jt.script = load("res://BreakableSpring.gd")
#	#print("node a = " + self.get_path())
#	#print("node b = " + body.get_path())
#	# Ajout du Ressort dans la scène (sinon inactif)
#	$Springs.add_child(jt)
#	return [body1, body2]
#
################################################################################################
## Cassage d'un ressorts trop tendus
#func breakSpring(j:Joint3D):
#	#print(str("RB PATH :" , j.get_node_a(), " & " , j.get_node_b())) # changer path ?
#	#var j: Joint = self as Joint
#	var nb: int		  = j.get_node_a().get_name_count()
#	var r1: RigidDynamicBody3D = get_node(str("Cells/" , j.get_node_a().get_name(nb-1)))
#	var r2: RigidDynamicBody3D = get_node(str("Cells/" , j.get_node_b().get_name(nb-1)))
#	#print("r2 : " + str(r2))
#	var d:float = 4.0
#	if(r1 != null && r2 != null):
#		d = r1.global_transform.origin.distance_to(r2.global_transform.origin)
#	else:
#		print("Un des Noeud est NULL !!!")
#	print("d : " + str(d))
#	# Casse si trop étiré (TODO : remplacer 2.1 par L-L0)
#	if(d > 30.0):
#		print("Break spring between : " + str(r1.get_name()) + " & " + str(r2.get_name()) + " d = " + str(d))
#		lst_cells_linked.erase([r1, r2]);
#		lst_cells_linked.erase([r2, r1]);
#		j.call_deferred("free")
