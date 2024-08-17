extends CollisionObject3D
class_name Interactable

@export var Prompt_message = "Interact"


func interact(body):
	print(body.name,"Touched " , name)
