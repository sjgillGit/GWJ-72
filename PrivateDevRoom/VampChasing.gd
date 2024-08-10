extends State
class_name VampChasing

@export var vampire : CharacterBody3D
var movement_speed: float = 4.0
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group('player')
@onready var movement_target_position: Vector3 = player.global_position
# TODO: Vampire chasing state


func Enter():
	player = get_tree().get_first_node_in_group('player')
	print('Chasing')

func Exit():
	pass

func Update(_delta):
	pass

@onready var navigation_agent: NavigationAgent3D = $'../../NavigationAgent3D'

func _ready():
	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func Physics_Update(_delta):
	movement_target_position = player.global_position
	# Look at player
	var distance = player.global_position - vampire.global_position
	if distance.length() < 15:
		Transitioned.emit(self, 'VampStalker')
		
	vampire.look_at(player.position, Vector3.UP)
	
	set_movement_target(movement_target_position)
	if navigation_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector3 = vampire.global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	
	vampire.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	vampire.move_and_slide()
	
	
	
