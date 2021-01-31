extends HBoxContainer

enum Type {
	BASS,
	TENOR,
	ALTO,
	SOPRANO
}

const ANIMATIONS = [
	"bass", "tenor", "alto", "soprano"
]

export(Type) var type = Type.BASS
onready var label = $Label
onready var sprite : AnimatedSprite = $Control/AnimatedSprite

var gem = null

func _ready():
	sprite.animation = ANIMATIONS[self.type]
	self.modulate.a = 0.3
	for gem in get_tree().get_nodes_in_group("Gems"):
		if gem.type == self.type:
			self.gem = gem
			set_gem(self.gem)
			break
	for totem in get_tree().get_nodes_in_group("totems"):
		if totem.type == self.type:
			totem.connect("completely_woken_up", self, "_on_totem_woken_up")
			break

func _on_totem_woken_up():
	self.modulate.a = 1.0

func set_gem(gem):
	label.text = gem.gem_name

