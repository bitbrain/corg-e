class_name Emote
extends Control

enum Type {
	HAPPY,
	DISAPPOINTED,
	SAD
}

const NAMES = ["happy", "disappointed", "-missing"]
const GEMS = ["bass", "tenor", "alto", "soprano"]


onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var tween = $DeletionTween

func _ready():
	self.visible = false

func play(type,gem=-1):
	self.modulate.a = 1
	tween.stop_all()
	if gem < 0:
		animation_player.play(NAMES[type])
	else:
		animation_player.play(GEMS[gem] + NAMES[type])
	self.visible = true
	
func _animation_complete():
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, 2.0)
	tween.start()

func _on_DeletionTween_tween_all_completed():
	if !tween.is_active():
		self.visible = false
