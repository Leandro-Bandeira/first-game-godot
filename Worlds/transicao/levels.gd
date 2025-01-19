extends Node

func _ready() -> void:
	if Global.fromWorld != null:
		# Define a posição global do Player para o nó especificado
		$Player.global_position = get_node(Global.fromWorld + "Pos").global_position
