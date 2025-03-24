extends CanvasLayer

@onready var inventario = $inventario

func _ready():
	inventario.close()

func _input(event):
	if event.is_action_pressed("abrir_inventario"):
		if inventario.isOpen:
			inventario.close()
		else:
			inventario.open()
