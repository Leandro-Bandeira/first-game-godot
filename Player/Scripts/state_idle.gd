class_name StateIdle extends State

@onready var walk : State = $"../Walk"

func enter() -> void:
	# Atualiza a animação do jogador para o estado "idle"
	player.updateAnimation("idle")

func exit() -> void:
	pass

func process(delta : float) -> State:
	# Verifica se o jogador está se movendo
	if player.movementDirection != Vector2.ZERO:
		return walk  # Transição para o estado "walk"

	# Define a velocidade do jogador como zero enquanto está parado
	player.velocity = Vector2.ZERO
	return null

func physics(delta : float) -> State:
	return null

func handleInput(event: InputEvent) -> State:
	return null
