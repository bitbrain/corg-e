extends Control

var ready_for_input = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Global.goto_scene("res://MainWorld.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			Global.goto_scene("res://MainWorld.tscn")
