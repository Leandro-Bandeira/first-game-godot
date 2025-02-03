extends Area2D

@onready var window_open =  $"../Sala_inicial/objects3"
@onready var window_closed = $"../Sala_inicial/objects"

@onready var player_window = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_window and Input.is_action_just_pressed("iteration"):
		window_open.visible = true
		window_closed.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		player_window = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		player_window = false
