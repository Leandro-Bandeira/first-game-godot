extends Area2D
var player_in_area := false
@export var dialogue_name: String = "estante4"
@export var book_number: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start_dialogue():

	print("Iniciando diálogo...")
	
	# Carrega o diálogo pelo nome
	var dialogue = Dialogic.start(dialogue_name)
	
	# Adiciona o diálogo à cena atual
	add_child(dialogue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("iteration"):
		start_dialogue()
		print("Nao tem nada por aqui 4")
		if book_number == Global.correct_sequence[Global.current_sequence.size()]:
			Global.current_sequence.append(book_number)
			print(Global.current_sequence)
		else:
			Global.reset_sequence()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		print('Proximo da estante_4')


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
		
