extends Node2D
var started : bool = false
var final_credits_position = -500
var credits_rolling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var def_credits_position = $Credits/RichTextLabel.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Escape") and started:
		visible = !visible
	if credits_rolling:
		$Credits/RichTextLabel.position.y = move_toward($Credits/RichTextLabel.position.y,final_credits_position, .5)
		if $Credits/RichTextLabel.position.y == final_credits_position or Input.is_action_just_pressed("Escape"):
			credits_rolling = false
			$Credits.visible = false


func _on_start_game_pressed():
	if started:
		visible = false
		return
	var scene = preload('res://Main/main.tscn')
	var instance = scene.instantiate()
	add_child(instance)
	visible = false
	started = true
	$"BoxContainer/Main menu".visible = true


func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	$Credits.visible = true
	credits_rolling = true

func _on_main_menu_pressed():
	started = false
	$"BoxContainer/Main menu".visible = false
	visible = true
	remove_child($'Main')
