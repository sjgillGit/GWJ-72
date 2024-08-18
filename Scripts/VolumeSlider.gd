extends HSlider
@export var audio_bus_name = "Master"
@onready var _bus = AudioServer.get_bus_index(audio_bus_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
	print(value, ' : ', linear_to_db(value))
