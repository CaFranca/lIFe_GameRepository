extends Control

signal opened
signal closed

var isOpen: bool = false

@onready var inventario: Inventario = preload("res://inventario/inventarioJogador.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventario.updated.connect(update)
	update()

func update():
	for i in range(min(inventario.itens.size(), slots.size())):
		slots[i].update(inventario.itens[i])

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
