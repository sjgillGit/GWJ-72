extends State
class_name VampIdle

@export var vampire : CharacterBody3D
var base_speed = 2
var speed = 2
var player : CharacterBody3D
# TODO: Vampire idle state


func Enter():
	player = get_tree().get_first_node_in_group('player')
	print('Idle')
	await get_tree().create_timer(10).timeout
	Transitioned.emit(self, 'VampStalker')

func Exit():
	pass

func Update(_delta):
	pass

func Physics_Update(_delta):
	var distance = player.global_position - vampire.global_position
	vampire.velocity.y -= 2 #Gravity
	vampire.look_at(player.position, Vector3.UP)
	if distance.length() < 2:
		Transitioned.emit(self, 'VampStalker')
	vampire.move_and_slide()

func _on_seen():
	Transitioned.emit(self, 'VampHiding')
