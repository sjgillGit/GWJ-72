extends Pipe


# Called when the node enters the scene tree for the first time.
func _ready():
	connections.append('left')
	connections.append('down')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
