extends Node
class_name Pipe

var active : bool = false
var input = []
var connections = []
@export var position_in_puzzle = [0, 0]
var puzzle

func _ready():
	pass

func activate(energy_direction: String) -> void:
	puzzle = get_parent()
	if energy_direction not in connections:
		return
	input.append(energy_direction)
	active = true
	$On.visible = true
	print('Activated: ', position_in_puzzle)
	for connection in connections:
		if connection != energy_direction:
			print('Activating: ', connection, ' from ', position_in_puzzle)
			puzzle.activate(position_in_puzzle, connection)

func deactivate(energy_direction: String) -> void:
	if energy_direction not in connections:
		return
	input.erase(energy_direction)
	if input == []:
		active = false
		$On.visible = false
		print('Deactivated: ', position_in_puzzle)
		for connection in connections:
			if connection != energy_direction:
				print('Deactivating: ', connection, ' from ', position_in_puzzle)
				puzzle.deactivate(position_in_puzzle, connection)
