extends Area2D


@onready var door_close = $Door_closed
@onready var door_open = $Door_open
@onready var door_blocker = $Door_blocker/CollisionShape2D   # O StaticBody2D que impede a passagem
@export var dialogue_name: String = "doorOpen"
@export var dialogue_name2: String = "door"
var player_nearby = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_close.visible = true  
	door_open.visible = false
	door_blocker.set_deferred("disabled", false)

func start_dialogue(dialogue_name):

	print("Iniciando diálogo...")
	
	# Carrega o diálogo pelo nome
	var dialogue = Dialogic.start(dialogue_name)
	
	# Adiciona o diálogo à cena atual
	add_child(dialogue)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("perto")
		player_nearby = true
		

func _process(delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("iteration"):
		var player = get_tree().get_first_node_in_group("player")
		if player and player.has_key:
			door_close.visible = false
			door_open.visible = true
			door_blocker.set_deferred("disabled", true)
			print("Abriu")
			start_dialogue(dialogue_name)
		else:
			print("Precisa da chave")
			start_dialogue(dialogue_name2)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
