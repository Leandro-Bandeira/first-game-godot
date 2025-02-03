extends Area2D

@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Global.exist_shadow:
		Global.can_shadow = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.can_shadow = false
		Global.shadow = false
		player.updateAnimation("idle2")
		player.updateAnimation("walk")
		
		
