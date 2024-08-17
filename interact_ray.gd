extends RayCast3D

@onready var prompt = $Prompt
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	prompt.text = ""
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.Prompt_message
			
			if Input.is_action_just_pressed("Mouse_1"):
				collider.interact(owner)
