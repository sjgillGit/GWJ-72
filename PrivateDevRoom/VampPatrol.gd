extends State
class_name VampPatrol

@export var vampire : CharacterBody3D
var movement_speed: float = 3.5
var player : CharacterBody3D 
@onready var retreats = get_tree().get_nodes_in_group('Retreats')
@onready var navigation_agent: NavigationAgent3D = $'../../NavigationAgent3D'
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group('player')


func Physics_Update(delta):
	# TODO: Make vampire take cover
	target = player
	var distance = target.global_position - vampire.global_position
	# Navigation target
	navigation_agent.set_target_position(target.global_position)
	var current_agent_position: Vector3 = vampire.global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	
	# Look forward 
	var target_position = target.global_position
	target_position.y = 1.3
	var new_transform = vampire.transform.looking_at(target_position, Vector3.UP)
	vampire.transform  = vampire.transform.interpolate_with(new_transform, 5 * delta)
	
	#vampire.rotation_degrees
	
	vampire.velocity.y -= 2 #Gravity
	vampire.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	#vampire.move_and_slide()
	
