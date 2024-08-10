extends State
class_name VampStalker

@export var vampire : CharacterBody3D
var movement_speed: float = 4.0
var targets
var target
# @onready var player : CharacterBody3D = get_tree().get_first_node_in_group('player')
# @onready var movement_target_position: Vector3 = player.global_position
# TODO: Vampire Stalker state


func Enter():
	targets = get_tree().get_nodes_in_group('targets')
	target = targets.pick_random()
	print('Stalking ', target.name)
	target = target.global_position

func Exit():
	pass

func Update(_delta):
	pass

func _on_seen():
	Transitioned.emit(self, 'VampHiding')

func Physics_Update(_delta):
	# movement_target_position = player.global_position
	# Look at marker
	
	vampire.look_at(target, Vector3.UP)
	vampire.velocity = vampire.global_position.direction_to(target) * movement_speed
	vampire.velocity.y -= 5 #Gravity
	vampire.move_and_slide()
	
func _on_timer_timeout():
	Transitioned.emit(self, 'VampStalker')
