extends Area2D

class_name coletavel

@export var itemRes: ItensInventario

func coletar(inventario: Inventario):
	inventario.inserir(itemRes)
	queue_free()
