class_name GameFinishedDetector
extends Node

signal game_finished

var totems

var woken_up_counter : int = 0

func _ready():
	self.totems = get_tree().get_nodes_in_group("totems")
	for totem in self.totems:
		totem.connect("completely_woken_up", self, "_totem_woken_up")
	
func _totem_woken_up():
	woken_up_counter += 1
	if woken_up_counter == totems.size():
		# GAME FINISHED! YEY!
		emit_signal("game_finished")
		return
	
