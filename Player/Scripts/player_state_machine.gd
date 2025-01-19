class_name PlayerStateMachine extends Node

# Lista de estados associados à máquina de estados
var states : Array[State]
var previousState : State
var currentState : State

func _ready() -> void:
	# Desativa o processamento inicialmente
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	# Processa o estado atual e possivelmente muda de estado
	changeState(currentState.process(delta))

func _physics_process(delta: float) -> void:
	# Processa a física do estado atual e possivelmente muda de estado
	changeState(currentState.physics(delta))

func _unhandled_input(event):
	# Processa a entrada do jogador e possivelmente muda de estado
	changeState(currentState.handleInput(event))

func initialize(player : Player) -> void:
	# Inicializa a máquina de estados com o jogador
	states = []

	# Adiciona todos os filhos que são estados à lista de estados
	for child in get_children():
		if child is State:
			states.append(child)

	# Define o primeiro estado como o estado inicial
	if states.size() > 0:
		states[0].player = player
		changeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func changeState(newState: State) -> void:
	# Verifica se o novo estado é válido e diferente do estado atual
	if newState == null or newState == currentState:
		return

	# Sai do estado atual, se existir
	if currentState:
		currentState.exit()

	# Atualiza os estados anterior e atual
	previousState = currentState
	currentState = newState

	# Entra no novo estado
	currentState.enter()
