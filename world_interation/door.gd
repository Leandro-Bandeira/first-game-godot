extends Area2D


@onready var door_close = $Door_closed
@onready var door_open = $Door_open
@onready var player_nearby_door = false
@onready var start_level =  preload("res://Worlds/MainLand.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_close.visible = true  
	door_open.visible = false


	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby_door = true
		
	
	#if body.has_key:
	#	door_close.visible = false
	#	door_open.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby_door = false
		
	

func _process(delta: float) -> void:
	if player_nearby_door and Input.is_action_just_pressed("iteration"):
		var player = get_tree().get_first_node_in_group("player")
		if player and player.has_key:
			door_close.visible = false
			door_open.visible = true
			TransitionScreen.transition() # Inicia a transição
			await TransitionScreen.on_transition_finished 
			get_tree().change_scene_to_packed(start_level)
			
		else:
			print("Precisa da chave")
