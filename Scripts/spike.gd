extends Area2D

func _on_body_entered(body): #reconhece o body que entrou na área
	if body.name == 'Player':
		get_tree().reload_current_scene() #reinicia a cena principal
	pass # Replace with function body.
