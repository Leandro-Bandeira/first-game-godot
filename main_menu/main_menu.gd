class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/start_button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button as Button
@onready var option_button = $MarginContainer/HBoxContainer/VBoxContainer/options_button as Button 
@onready var option_menu = $Options_Menu as Options_Menu
@onready var margin_container = $MarginContainer as MarginContainer

# Save in the memory in a scene
@onready var start_level =  preload("res://Worlds/MainLand.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connections_signals()	
func on_start_down() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_down() -> void:
	get_tree().quit()
	
func on_option_down() -> void:
	margin_container.visible = false
	option_menu.set_process(true)
	option_menu.visible = true
	
func on_exit_option_menu() -> void:
	margin_container.visible = true
	
	option_menu.visible = false
	

func handle_connections_signals() -> void:
	start_button.button_down.connect(on_start_down)
	option_button.button_down.connect(on_option_down)
	exit_button.button_down.connect(on_exit_down)
	option_menu.exit_opition_menu.connect(on_exit_option_menu)
	
