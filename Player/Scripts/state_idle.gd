class_name StateIdle extends State

@onready var walk : State = $"../Walk"

func enter() -> void:
	# Atualiza a animação do jogador para o estado "idle"
	#if(getParentN(3).name.to_lower().find("gelo") != -1):
	#	player.updateAnimation("idleCold")
	#else:
	player.updateAnimation("idle")

	
# Função para pegar um nó "mais acima" (n parent)
func getParentN(n: int) -> Node:
	var node = self
	for i in range(n):
		node = node.get_parent()
		if node == null:
			return null  # Retorna null caso o nó pai não exista
	return node

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
