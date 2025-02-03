@tool
class_name NPC2 extends CharacterBody2D

signal do_behavior_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"
var do_behavior : bool = true
var player_in_range = false
var player_in_vision = false

@export var npc_resource : NPCResource : set = _set_npc_resource
@export var dialogue_name: String = "npc_dialogue"
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var player: Player = $"../Player"
@onready var shape_cast: ShapeCast2D = $ShapeCast2D
@onready var collisionPolygon2 = $"../npc2/VisionArea/CollisionPolygon2D"
@onready var collisionPolygon1 = $"../npc/VisionArea/CollisionPolygon2D"
@onready var respawn: Marker2D = $"../Marker2D"
@onready var rotation_base_shape_cast = 0
@onready var rotation_base_collision2 = 0
@onready var rotation_base_collision1 = 0

func _ready() -> void:
	rotation_base_shape_cast = shape_cast.rotation_degrees
	rotation_base_collision2 = collisionPolygon2.rotation_degrees
	rotation_base_collision1 = collisionPolygon1.rotation_degrees
	setup_npc()
	if Engine.is_editor_hint():
		return
	do_behavior_enabled.emit()
	pass

func _physics_process(delta: float) -> void:
	
	if direction_name == "down":
		shape_cast.rotation_degrees = rotation_base_shape_cast
		collisionPolygon2.rotation_degrees = rotation_base_collision2
		collisionPolygon1.rotation_degrees = rotation_base_collision1
		
	move_and_slide()
	if player_in_vision:
		print("aqui")
		if can_see_player():
			print("Jogador detectado visualmente!")

func can_see_player():
	shape_cast.force_shapecast_update()  # Atualiza a detecção
	if shape_cast.is_colliding():
		for i in shape_cast.get_collision_count():
			var collider = shape_cast.get_collider(i)
			if collider == player:
				print("Jogador detectado!")
				kill_player()  # Exemplo de ação
				break
	
func kill_player():
	player.global_position = respawn.global_position

func update_animation() -> void:
	animation.play( state + "_" + direction_name )

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("here")
		player_in_vision = true
		

func _on_vision_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_vision = false

func update_direction( target_position : Vector2 ) -> void:
	direction = global_position.direction_to( target_position )
	update_direction_name()
	if direction_name == "side" and direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func update_direction_name() -> void:
	var threshold : float = 0.45
	if direction.y < -threshold:
		direction_name = "up"
		shape_cast.rotation_degrees += 180
		collisionPolygon2.rotation_degrees += 180
		collisionPolygon1.rotation_degrees += 180
	elif direction.y > threshold:
		direction_name = "down"
	elif direction.x > threshold || direction.x < -threshold:
		direction_name = "side"

func setup_npc() -> void:
	if npc_resource:
		if sprite:
			sprite.texture = npc_resource.sprite
	pass

func _set_npc_resource( _npc : NPCResource ) -> void:
	npc_resource = _npc
	setup_npc()
