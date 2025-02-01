extends Node

var fromWorld
var current_sequence: Array = []
var correct_sequence: Array = [1, 2, 3, 4, 5]  # Ordem esperada

func reset_sequence() -> void:
	Global.current_sequence.clear()
