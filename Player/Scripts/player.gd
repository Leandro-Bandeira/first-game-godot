class_name Player extends CharacterBody2D

# Direção cardinal para onde o jogador está virado (inicialmente para baixo)
var cardinalDirection : Vector2 = Vector2.DOWN
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
	# Atualiza a direção cardinal baseada no vetor de movimento
	var newDirection : Vector2 = cardinalDirection

	# Se o jogador não estiver se movendo, não muda a direção
	if movementDirection == Vector2.ZERO:
		return false

	# Determina a nova direção com base no eixo predominante
	if movementDirection.y == 0:
		newDirection = Vector2.LEFT if movementDirection.x < 0 else Vector2.RIGHT
	elif movementDirection.x == 0:
		newDirection = Vector2.UP if movementDirection.y < 0 else Vector2.DOWN

	# Se a direção não mudou, retorna falso
	if newDirection == cardinalDirection:
		return false

	# Atualiza a direção cardinal e ajusta a escala do sprite
	cardinalDirection = newDirection
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
