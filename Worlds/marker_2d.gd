extends Marker2D

func spawn_key() -> void:
	print('Here')
	var key_scene = preload("res://scenes_obj/key.tscn")
	var key = key_scene.instantiate()
	get_tree().current_scene.add_child(key)
	#key.global_position = global_position
