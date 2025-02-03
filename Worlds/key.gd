extends Area2D

@export var dialogue_name: String = "timeline"
@onready var key = $sprite_key
var player_in_range = false
var dialogo_reproduzido = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	pass # Replace with function body.

func start_dialogue():
	if not dialogo_reproduzido:
		print("Iniciando diálogo...")
		
		# Carrega o diálogo pelo nome
		var dialogue = Dialogic.start(dialogue_name)
		
		dialogo_reproduzido = true
		
		# Adiciona o diálogo à cena atual
		add_child(dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if Global.shadow:
		body.has_key = true
		start_dialogue()
		key.visible = false
	#queue_free()
	
