extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $Letras_aparecendo

const larguraMAX = 256

var texto = ""
var letras_index = 0

var letras_timer = 0.03
var espaço_timer = 0.06
var pontuação_timer = 0.2

signal acabar_texto()

func mostrar_texto(text_to_display: String):
	texto = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, larguraMAX)
	if size.x > larguraMAX:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y

	global_position.x -= size.x /2
	global_position.y -= size.y + 24
	
	label.text = ""
	_mostrar_letra()
	
func _mostrar_letra():
	label.text += texto[letras_index]
	letras_index += 1
	if letras_index >= texto.length():
		acabar_texto.emit()
		return
	
	match texto[letras_index]:
		"!", ",", "?", ".":
			timer.start(pontuação_timer)
		" ":
			timer.start(espaço_timer)
		_:
			timer.start(letras_timer)


func _on_letras_aparecendo_timeout():
	_mostrar_letra()
