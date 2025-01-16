class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
	
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	# Se o jogador não estiver se movendo, retorna ao estado idle
	if player.direction == Vector2.ZERO:
		return idle

	player.direction = player.direction.normalized()
	player.velocity = player.direction * move_speed

	if player.SetDirection():
		player.UpdateAnimation("walk")

	return null

func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_envent: InputEvent) -> State:
	return null
