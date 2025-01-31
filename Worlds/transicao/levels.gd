extends Node

@export var music : AudioStream

func _ready() -> void:
	AudioManager.playMusic(music)
	if Global.fromWorld != null:
		# Define a posição global do Player para o nó especificado
		$Player.global_position = get_node(Global.fromWorld + "Pos").global_position
