extends CharacterBody2D

# Variável para controlar se o jogador está na área de interação
var player_in_range = false
var player_in_vision = false # Para detecção visual


# Nome do diálogo que será carregado (o mesmo nome que você criou no Dialogic)
@export var dialogue_name: String = "npc_dialogue"
@onready var player: Player = $"../Player"
@onready var shape_cast: ShapeCast2D = $ShapeCast2D

@onready var respawn: Marker2D = $"../Marker2D"

func _ready() -> void:
	pass

# Função chamada quando o jogador entra na área de detecção
func _on_area_2d_body_entered(body):
	if body.name == "Player":  # Substitua "Player" pelo nome do nó do jogador
		player_in_range = true
		print("Jogador está próximo.")

# Função chamada quando o jogador sai da área de detecção
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		print("Jogador saiu.")

# Função chamada a cada frame
func _physics_process(delta):
	# Atualiza direção do raycast
	
	#raycast.target_position = forward_direction
	#raycast.force_raycast_update()
	# Verifica visão do jogador (enquanto ele está na área)
	if player_in_vision:
		print("aqui")
		if can_see_player():
			print("Jogador detectado visualmente!")
			#kill_player()
	
	if player_in_range and Input.is_action_just_pressed("ui_interact"):  # Verifica se "E" foi pressionada
		start_dialogue()

# Função para iniciar o diálogo usando o Dialogic
func start_dialogue():
	print("Iniciando diálogo...")
	
	# Carrega o diálogo pelo nome
	var dialogue = Dialogic.start(dialogue_name)
	
	# Adiciona o diálogo à cena atual
	add_child(dialogue)
	
	# Conecta o sinal de fim de diálogo corretamente
	if dialogue.has_signal("timeline_ended"):
		dialogue.timeline_ended.connect(_on_dialogue_end)
	else:
		print("Erro: O sinal 'timeline_ended' não foi encontrado no diálogo.")

# Função chamada quando o diálogo termina (opcional)
func _on_dialogue_end():
	print("Diálogo terminado.")
	# Aqui você pode adicionar lógica para após o diálogo, como dar um item ao jogador, etc.

func can_see_player():
	shape_cast.force_shapecast_update()  # Atualiza a detecção
	if shape_cast.is_colliding():
		for i in shape_cast.get_collision_count():
			var collider = shape_cast.get_collider(i)
			if collider == player:
				print("Jogador detectado!")
				kill_player()  # Exemplo de ação
				break
	
func kill_player():
	player.global_position = respawn.global_position
	
func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("here")
		player_in_vision = true
		

func _on_vision_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_vision = false
