extends Button

# Referência ao nó do plano cartesiano (vai ser mostrado e escondido)
@onready var cartesian_plane = get_node("../CartesianPlane")

func _on_pressed():
	# Mostra ou esconde o plano cartesiano
	cartesian_plane.visible = !cartesian_plane.visible
	pass # Replace with function body.
