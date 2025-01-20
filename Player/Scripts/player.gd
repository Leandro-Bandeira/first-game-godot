class_name Player extends CharacterBody2D

# Direção cardinal para onde o jogador está virado (inicialmente para baixo)
var cardinalDirection : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
# Vetor de direção do movimento atual do jogador
var movementDirection : Vector2 = Vector2.ZERO

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var stateMachine : PlayerStateMachine = $StateMachine

func _ready() -> void:
	# Inicializa a máquina de estados do jogador
	stateMachine.initialize(self)

func _process(delta):
	# Calcula a direção do movimento com base nas teclas pressionadas
	movementDirection.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	movementDirection.y = Input.get_action_strength("down") - Input.get_action_strength("up")

func _physics_process(delta):
	# Move o jogador considerando colisões
	move_and_slide()

func setDirection() -> bool:
	# Verifica se o jogador não está se movendo
	if movementDirection == Vector2.ZERO:
		return false  

	# Calcula o ID da direção com base no ângulo de movementDirection
	var directionID : int = int(round((movementDirection).angle() / TAU * DIR_4.size()))
	var newDirection = DIR_4[directionID]  # Obtém a nova direção usando o ID

	# Verifica se a nova direção é igual à direção atual
	if newDirection == cardinalDirection:
		return false  

	# Atualiza a direção cardinal
	cardinalDirection = newDirection

	# Ajusta a escala do sprite com base na direção (inverte no eixo X se for esquerda)
	sprite.scale.x = -1 if cardinalDirection == Vector2.LEFT else 1

	return true  

func updateAnimation(state : String) -> void:
	# Atualiza a animação com base no estado e na direção
	animationPlayer.play(state + "_" + getAnimDirection())

func getAnimDirection() -> String:
	# Retorna a direção cardinal como string para uso nas animações
	if cardinalDirection == Vector2.DOWN:
		return "down"
	elif cardinalDirection == Vector2.UP:
		return "up"
	else:
		return "side"
