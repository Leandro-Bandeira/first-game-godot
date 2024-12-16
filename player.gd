extends CharacterBody2D

# Velocidade do personagem
var walk_speed = 15.0
const TILE_SIZE = 15

# Conecta ao AnimationTree
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

# Define os estados do jogador
enum PlayerState {IDLE, TURNING, WALKING}
enum FacingDirection {LEFT, RIGHT, UP, DOWN}

# Estado inicial
var current_state = PlayerState.IDLE
var current_direction = FacingDirection.DOWN
var start_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var move_progress = 0.0

# Ativa as animações e define a posição inicial
func _ready():
    animation_tree.active = true
    start_position = position

# Gerencia a física do personagem
func _physics_process(delta):
    if current_state == PlayerState.TURNING:
        return
    elif not is_moving:
        process_player_input()
    elif input_direction != Vector2.ZERO:
        animation_state.travel("Walk")
        move(delta)
    else:
        animation_state.travel("Idle")
        is_moving = false

# Processa a entrada do jogador
func process_player_input():
    if input_direction.y == 0:
        input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    if input_direction.x == 0:
        input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

    if input_direction != Vector2.ZERO:
        animation_tree.set("parameters/Idle/blend_position", input_direction)
        animation_tree.set("parameters/Walk/blend_position", input_direction)
        animation_tree.set("parameters/Turn/blend_position", input_direction)

        if needs_to_turn():
            current_state = PlayerState.TURNING
            animation_state.travel("Turn")
        else:
            start_position = position
            is_moving = true
    else:
        animation_state.travel("Idle")

# Verifica se é necessário virar
func needs_to_turn():
    var new_direction
    if input_direction.x < 0:
        new_direction = FacingDirection.LEFT
    elif input_direction.x > 0:
        new_direction = FacingDirection.RIGHT
    elif input_direction.y < 0:
        new_direction = FacingDirection.UP
    elif input_direction.y > 0:
        new_direction = FacingDirection.DOWN

    if current_direction != new_direction:
        current_direction = new_direction
        return true
    current_direction = new_direction
    return false

# Finaliza a animação de virar
func finish_turning():
    current_state = PlayerState.IDLE

# Gerencia o movimento do personagem
func move(delta):
    move_progress += walk_speed * delta
    if move_progress >= 1.0:
        position = start_position + (TILE_SIZE * input_direction)
        move_progress = 0.0
        is_moving = false
    else:
        position = start_position + (TILE_SIZE * input_direction * move_progress)
