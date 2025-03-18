extends Area2D

func _on_Area2D_body_entered(body):
	print("Colidiu com: ", body.name)  # Imprime o nome do corpo que colidiu
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()
