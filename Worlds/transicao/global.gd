extends Node

var exist_shadow = false
var fromWorld
var current_sequence: Array = []
var correct_sequence: Array = [1, 2, 3, 4, 5]  # Ordem esperada
var shadow = false
var can_shadow = false
func reset_sequence() -> void:
	Global.current_sequence.clear()
