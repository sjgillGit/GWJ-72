# Just add new pipes in the puzzle layout section, 
# everything else should be automated
# 

extends Node2D

var pipes = Array()
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5): 
		pipes.append([])
		for j in range(5): 
			pipes[i].append(j)
	print(pipes)
	
	###   Puzzle layout is here   ###
	pipes[0][2] = $Pipe_source
	pipes[1][2] = $Pipe_L2
	pipes[1][3] = $PipeVert
	pipes[1][4] = $Pipe_L4
	pipes[2][3] = $PipeL
	pipes[2][4] = $Pipe_L3
	pipes[3][2] = $PipeHor2
	pipes[3][3] = $PipeHor
	pipes[4][0] = $PipeVert4
	pipes[4][1] = $PipeVert3
	pipes[4][2] = $PipeT
	pipes[4][3] = $Pipe_L32
	###   Puzzle layout is here   ###
	
	for i in range(5): 
		for j in range(5): 
			if pipes[i][j] is Pipe:
				pipes[i][j].position.x = i*100 + 300
				pipes[i][j].position.y = j*100 + 300
				pipes[i][j].position_in_puzzle[0] = i
				pipes[i][j].position_in_puzzle[1] = j
	
	pipes[0][2].activate('left')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		if pipes[0][2].active == true:
			pipes[0][2].deactivate('left')
		else:
			pipes[0][2].activate('left')

func activate(position_in_puzzle, direction):
	if direction == 'right':
		if position_in_puzzle[0] == 4:
			return 
		if pipes[position_in_puzzle[0]+1][position_in_puzzle[1]] is Pipe:
			pipes[position_in_puzzle[0]+1][position_in_puzzle[1]].activate('left')
	if direction == 'down':
		if position_in_puzzle[1] == 4:
			return
		if pipes[position_in_puzzle[0]][position_in_puzzle[1]+1] is Pipe:
			pipes[position_in_puzzle[0]][position_in_puzzle[1]+1].activate('up')
	if direction == 'up':
		if position_in_puzzle[1] == 0:
			return
		if pipes[position_in_puzzle[0]][position_in_puzzle[1]-1] is Pipe:
			pipes[position_in_puzzle[0]][position_in_puzzle[1]-1].activate('down')
	if direction == 'left':
		if position_in_puzzle[0] == 0:
			return
		if pipes[position_in_puzzle[0]-1][position_in_puzzle[1]] is Pipe:
			pipes[position_in_puzzle[0]-1][position_in_puzzle[1]].activate('right')

func deactivate(position_in_puzzle, direction):
	if direction == 'right':
		if position_in_puzzle[0] == 4:
			return 
		if pipes[position_in_puzzle[0]+1][position_in_puzzle[1]] is Pipe:
			pipes[position_in_puzzle[0]+1][position_in_puzzle[1]].deactivate('left')
	if direction == 'down':
		if position_in_puzzle[1] == 4:
			return
		if pipes[position_in_puzzle[0]][position_in_puzzle[1]+1] is Pipe:
			pipes[position_in_puzzle[0]][position_in_puzzle[1]+1].deactivate('up')
	if direction == 'up':
		if position_in_puzzle[1] == 0:
			return
		if pipes[position_in_puzzle[0]][position_in_puzzle[1]-1] is Pipe:
			pipes[position_in_puzzle[0]][position_in_puzzle[1]-1].deactivate('down')
	if direction == 'left':
		if position_in_puzzle[0] == 0:
			return
		if pipes[position_in_puzzle[0]-1][position_in_puzzle[1]] is Pipe:
			pipes[position_in_puzzle[0]-1][position_in_puzzle[1]].deactivate('right')


func shift_up(column : int):
	pipes[0][2].deactivate('left')
	var pipes_moved = pipes[column]
	var buffer
	
	for i in range(4):
		buffer = pipes_moved[i]
		pipes_moved[i] = pipes_moved[i+1]
		pipes_moved[i+1] = buffer
		if pipes_moved[i] is Pipe:
			pipes_moved[i].position_in_puzzle[1] = i
			pipes_moved[i].position.y = i*100 + 300
		if pipes_moved[i+1] is Pipe:
			pipes_moved[i+1].position_in_puzzle[1] = i+1
			pipes_moved[i+1].position.y = (i+1)*100 + 300
	
	pipes[column] = pipes_moved
	pipes[0][2].activate('left')

func shift_down(column : int):
	pipes[0][2].deactivate('left')
	
	var pipes_moved = pipes[column]
	var back = pipes_moved.pop_back()
	pipes_moved.push_front(back)
	
	for i in range(5):
		if pipes_moved[i] is Pipe:
			pipes_moved[i].position_in_puzzle[1] = i
			pipes_moved[i].position.y = i*100 + 300
	
	pipes[column] = pipes_moved
	pipes[0][2].activate('left')
