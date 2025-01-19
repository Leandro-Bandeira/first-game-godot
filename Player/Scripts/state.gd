class_name State extends Node
#Classe abstrata

# Referência estática para o jogador
static var player : Player

func _ready() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(delta : float) -> State:
	return null

func physics(delta : float) -> State:
	return null

func handleInput(event: InputEvent) -> State:
	return null
