class_name StateIdle extends State

@onready var walk : State = $"../Walk"




func enter() -> void: 
	# Atualiza a animação do jogador para o estado "idle"
	if(Global.shadow == true):
		player.updateAnimation("walk2")
	else:
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
	if Input.is_action_just_pressed("sombra") and not Global.shadow and Global.can_shadow:
		print("ShadowON")
		player.updateAnimation("idle3")
		Global.shadow = true
	elif Input.is_action_just_pressed("sombra") and Global.shadow: 
		Global.shadow = false
		print("ShadowOFF")
		player.updateAnimation("idle2")
	
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
