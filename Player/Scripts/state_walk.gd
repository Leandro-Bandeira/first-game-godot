class_name StateWalk extends State

@export var moveSpeed : float = 75.0
@onready var idle : State = $"../Idle"


func enter() -> void:
	# Atualiza a animação do jogador para o estado "walk"
	if(Global.shadow == true):
		player.updateAnimation("walk2")
	else:
		player.updateAnimation("walk")

func exit() -> void:
	# Executa ao sair do estado "walk"
	pass

func process(delta: float) -> State:

	if player.movementDirection == Vector2.ZERO:
		return idle

	# Normaliza a direção e calcula a velocidade do jogador
	player.movementDirection = player.movementDirection.normalized()
	player.velocity = player.movementDirection * moveSpeed

	# Atualiza a animação se a direção mudar
	if player.setDirection():
		if(Global.shadow == true):
			player.updateAnimation("walk2")
		else:
			player.updateAnimation("walk")

	return null

func physics(delta : float) -> State:
	return null

func handleInput(event: InputEvent) -> State:
	return null
