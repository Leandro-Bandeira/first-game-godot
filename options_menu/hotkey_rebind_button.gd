class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name: String  = "left" 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Enable handled keys for keyboard
	set_process_unhandled_key_input(false)
	set_action_name()
	
	
func set_action_name()->void:
	label.text = 'Unasignned'
	
	match action_name:
		"left":
			label.text = "left"
		"right":
			label.text = "right"
		"down":
			label.text = "down"
		"up":
			label.text = "up"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
