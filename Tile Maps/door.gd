extends TileMapLayer

@onready var door_close = $Door_closed
@onready var door_open = $Door_open
@onready var door_blocker = $Door_blocker/CollisionShape2D   # O StaticBody2D que impede a passagem
var player_nearby = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
