extends Area2D

enum Type {
	BASS,
	TENOR,
	ALTO,
	SOPRANO
}

const PICKUP_SPEED_MULTIPLIER = 1
const MIN_DISTANCE = 16
const LIGHT_COLOURS = [
	"ff4b98", # BASS
	"90ff58", # TENOR
	"ff5649", #ALTO
	"59dfff"  # SOPRANO
	]

export(Type) var type = Type.BASS

onready var sprite = $Sprite
onready var light = $Light2D

var body : Node2D = null

func _ready():
	sprite.frame = type
	light.color = Color(LIGHT_COLOURS[type])

func _physics_process(delta):
	if body != null:
		var distance = position.distance_to(body.position)
		if distance < MIN_DISTANCE:
			return
		self.position = self.position.move_toward(self.body.position, PICKUP_SPEED_MULTIPLIER * distance * delta)

func _on_Gem_body_entered(body):
	self.body = body as Node2D
