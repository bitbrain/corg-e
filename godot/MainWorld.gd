extends Node2D

func _ready():
	$Background.visible = true
	$CanvasLayer/ColorRect.visible = true
	$CanvasLayer/ColorRect.modulate.a = 0

func _on_GameFinishedDetector_game_finished():
	$GameCompleteTween.interpolate_property($CanvasLayer/ColorRect, "modulate:a", 0.0, 1.0, 10.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, 5.0)
	$GameCompleteTween.start()

func _on_GameCompleteTween_tween_all_completed():
	Global.goto_scene("res://screens/EndScreen.tscn")
