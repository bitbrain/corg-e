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

export(Type) var type = Type.BASS

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var light = $Light2D

func _ready():
	animation_player.play(ANIMATION_EXTENSIONS[type] + "Idle")
	light.color = Color(LIGHT_COLOURS[type])	
