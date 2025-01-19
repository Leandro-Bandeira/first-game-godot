extends Area2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

# Função chamada quando um corpo entra na área de transição
func _on_body_entered(body):
	call_deferred('changeLevel') 
	
#Função para trocar o mundo
func changeLevel():
	Global.fromWorld = get_parent().name
	get_tree().change_scene_to_file("res://Worlds/" + name + ".tscn")
