class_name Totem
extends StaticBody2D

enum Type {
	BASS,
	TENOR,
	ALTO,
	SOPRANO
}

export(Type) var type = Type.BASS

onready var ysort = $YSort
onready var sprite = $YSort/Sprite
onready var gem_slot_position = $GemSlotPosition.global_position

var gem:Gem = null

func _ready():
	sprite.frame = type


func _on_GemDetectionArea_area_entered(area):
	if area is Gem && self.gem == null && self.type == area.type:
		# duplicate to avoid reparenting issues
		var old_global_pos = area.global_position
		self.gem = area.duplicate()
		self.gem.assign_totem(self)
		ysort.add_child(self.gem)
		# remove old gem
		area.get_parent().remove_child(area)
		area.queue_free()
		# set the correct global pos after reparenting
		self.gem.global_position = old_global_pos
