class_name Alien
extends KinematicBody2D

enum Type {
	BASS,
	TENOR,
	ALTO,
	SOPRANO
}

const ANIMATION_EXTENSIONS = [
	"Bass", "Tenor", "Alto", "Soprano"
]
const LIGHT_COLOURS = [
	"ff4b98", # BASS
	"90ff58", # TENOR
	"ff5649", #ALTO
	"59dfff"  # SOPRANO
	]

export(NodePath) var totem_path
export(Type) var type = Type.BASS

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var light = $Light2D
onready var emote = $Emote

var totem
var entered_gems = []

func _ready():
	self.totem = get_node(totem_path)
	if self.totem != null:
		self.totem.connect("completely_woken_up", self, "_on_totem_woken_up")
	animation_player.play(ANIMATION_EXTENSIONS[type] + "Idle")
	animation_player.advance(randf())
	light.color = Color(LIGHT_COLOURS[type])
	
func _on_totem_woken_up():
	emote(Emote.Type.HAPPY)
	
func emote(type):
	emote.play(type)

func _on_InteractionArea_area_entered(area):
	if area is Gem and area.type != type and !entered_gems.has(area):
		emote(Emote.Type.DISAPPOINTED)
		entered_gems.append(area as Gem)

func _on_InteractionArea_area_exited(area):
	if area is Gem and area.type != type:
		entered_gems.erase(area as Gem)
