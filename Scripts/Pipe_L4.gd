extends Pipe


# Called when the node enters the scene tree for the first time.
func _ready():
	connections.append('up')
	connections.append('right')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
