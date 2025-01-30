class_name Options_Menu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/exit_button_option as Button

signal exit_opition_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.button_down.connect(on_exit_down)
	set_process(false)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_exit_down() -> void:
	exit_opition_menu.emit()
	set_process(false)
