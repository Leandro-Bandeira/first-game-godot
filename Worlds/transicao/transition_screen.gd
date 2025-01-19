extends CanvasLayer

signal on_transition_finished

@onready var colorRect = $ColorRect
@onready var animationPlayer = $AnimationPlayer

#Deixa a nimeção invativa e conecta a proxima função
func _ready():
	colorRect.visible = false
	animationPlayer.animation_finished.connect(_on_animation_finished)

# Termina animação de transição
func _on_animation_finished(animationName):
	if animationName == "fade_to_black":
		emit_signal("on_transition_finished")
		animationPlayer.play("fade_to_normal")
	elif animationName == "fade_to_normal":
		colorRect.visible = false
		
# Inicia animação de transição
func transition():
	colorRect.visible = true
	animationPlayer.play("fade_to_black")
