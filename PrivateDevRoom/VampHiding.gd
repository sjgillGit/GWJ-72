extends State
class_name VampHiding

@export var vampire : CharacterBody3D
var movement_speed: float = 3.5
var player : CharacterBody3D 
@onready var retreats = get_tree().get_nodes_in_group('Retreats')
@onready var navigation_agent: NavigationAgent3D = $'../../NavigationAgent3D'
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group('player')

func Enter():
	print('Hiding')
	var ret_num = retreats.size()
	ret_num = randi_range(0, ret_num-1)
	target = retreats[ret_num]
	navigation_agent.set_target_position(target.global_position)

	await get_tree().create_timer(15).timeout
	Transitioned.emit(self, 'VampChasing')
	
func Exit():
	pass
	

func Physics_Update(_delta):
	# TODO: Make vampire take cover
	var distance = target.global_position - vampire.global_position
	vampire.look_at(player.position, Vector3.UP)
	vampire.velocity.y -= 2 #Gravity
	
	# Look at player
	vampire.look_at(player.position, Vector3.UP)
	
	if navigation_agent.is_navigation_finished():
		if distance.length() < 5:
			Transitioned.emit(self, 'VampChasing')
		return
	
	var current_agent_position: Vector3 = vampire.global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	
	vampire.velocity.y -= 2 #Gravity
	vampire.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	vampire.move_and_slide()
	
	

func _LOS_lost():
	pass
