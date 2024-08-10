extends Node3D


@onready var camera := $CameraVert
@onready var neck := $"."

func _unhandled_input(event):
	#Stops mouse from moving
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == (Input.MOUSE_MODE_CAPTURED):
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-90), deg_to_rad(45))
