class_name Alien
extends KinematicBody2D

enum Type {
	BASS,
	TENOR,
	ALTO,
	SOPRANO
}

export(Type) var type = Type.BASS

onready var sprite = $Sprite

func _ready():
	sprite.frame = type
