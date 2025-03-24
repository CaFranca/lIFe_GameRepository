extends Node2D

@onready var inventario = $inventario
	
func _on_inventario_closed():
	get_tree().paused = false
	
func _on_inventario_opened():
	get_tree().paused = true
