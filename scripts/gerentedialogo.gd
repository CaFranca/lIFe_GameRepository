extends Node

@onready var caixa_texto_cena = preload("res://cenas/caixa_dialogo.tscn")

var linhas_dialogo: Array[String] = []
var linha_atual_index 

var caixa_texto
var caixa_texto_posição: Vector2

var dialogo_ativo = false
var passar_proxima_linha = false

signal dialogo_acaba()

func inicia_dialogo(position: Vector2, lines: Array[String]):
	if dialogo_ativo:
		return
	
	
	linhas_dialogo = lines 
	caixa_texto_posição = position
	linha_atual_index = 0
	_mostrar_caixa_texto()
	
	dialogo_ativo = true
	
func _mostrar_caixa_texto():
	caixa_texto = caixa_texto_cena.instantiate()
	caixa_texto.acabar_texto.connect(_na_caixa_texto_mostrando)
	get_tree().root.add_child(caixa_texto)
	caixa_texto.global_position = caixa_texto_posição
	caixa_texto.mostrar_texto(linhas_dialogo[linha_atual_index])
	passar_proxima_linha = false

func _na_caixa_texto_mostrando():
	passar_proxima_linha = true
	
func _unhandled_input(event):
	if (
		event.is_action_pressed("pula_dialogo") &&
		dialogo_ativo &&
		passar_proxima_linha
	):
		caixa_texto.queue_free()
		
		linha_atual_index += 1
		if linha_atual_index >= linhas_dialogo.size():
			dialogo_ativo  = false
			linha_atual_index = 0
			dialogo_acaba.emit()
			return
			
		_mostrar_caixa_texto()
