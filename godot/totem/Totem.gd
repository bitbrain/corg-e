class_name Totem
extends StaticBody2D

const MIN_GEM_DISTANCE = 3

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
onready var animation_player = $TotemActivationPlayer
onready var activation_line_sprite = $YSort/Sprite/ActivationLineSprite
onready var face_sprite = $FaceActivationSprite

var gem:Gem = null

var sleeping = true

func _ready():
	sprite.frame = type
	
func _physics_process(delta):
	if sleeping && gem != null:
		var distance = gem.global_position.distance_to(gem_slot_position)
		if distance < MIN_GEM_DISTANCE:
			# WAKE UP!
			gem.global_position = gem_slot_position
			sleeping = false
			activation_line_sprite.visible = true
			face_sprite.visible = true
			# TODO select animation based on type
			animation_player.play("ActivateTotemBass")
		else:
			gem.global_position = gem.global_position.move_toward(gem_slot_position, distance * delta)

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
		
func _completely_woken_up():
	# TODO select animation based on type
	animation_player.play("SingingTotemBass")
