extends Resource

class_name Inventario

signal updated

@export var itens: Array[ItensInventario]

func inserir(item: ItensInventario):
	for i in range (itens.size()):
		if !itens[i]:
			itens[i] = item
			break
	updated.emit()
