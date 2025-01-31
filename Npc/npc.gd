extends CharacterBody2D

# Variável para controlar se o jogador está na área de interação
var player_in_range = false

# Nome do diálogo que será carregado (o mesmo nome que você criou no Dialogic)
@export var dialogue_name: String = "npc_dialogue"

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
func _process(delta):
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
