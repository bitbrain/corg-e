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
			gem.connect("on_gem_inserted", self, "set_gem")
			self.gem = gem
			break
	self.label.text = self.gem.gem_name
	
func set_gem(gem):
	label.text = gem.gem_name
	self.modulate.a = 1.0

