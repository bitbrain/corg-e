class_name Emote
extends Control

enum Type {
	HAPPY,
	DISAPPOINTED
}

const NAMES = ["happy", "disappointed"]

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var tween = $DeletionTween

func _ready():
	self.visible = false

func play(type):
	animation_player.play(NAMES[type])
	self.visible = true
	
func _animation_complete():
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func _on_DeletionTween_tween_all_completed():
	self.visible = false
