extends Node2D

func _on_inventario_closed() -> void:
	get_tree().paused = false

func _on_inventario_opened() -> void:
	get_tree().paused = true
