class_name Character
extends KinematicBody2D

export var ACCELERATION = 500
export var FRICTION = 140
export var MAX_SPEED = 70

enum {
	MOVE
}

onready var engine_sound = $EngineSound
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var velocity = Vector2.ZERO
var state = MOVE
var default_speed = 1

func _physics_process(delta):
	match state:
		MOVE:	
			move_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		if !engine_sound.playing:
			engine_sound.play()
		engine_sound.volume_db /= 1.05
		engine_sound.volume_db = clamp(engine_sound.volume_db, -50, -36)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		engine_sound.volume_db *= 1.05
		engine_sound.volume_db = clamp(engine_sound.volume_db, -50, -36)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	engine_sound.pitch_scale = max(0.1, abs(velocity.length() / 10))
	animation_tree.set("parameters/Idle/blend_position", velocity.normalized())
	animation_state.travel("Idle")
