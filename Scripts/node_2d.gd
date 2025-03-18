extends Node2D

var grid_size: int = 20  # Tamanho dos quadrados da malha
var grid_color: Color = Color(0.1, 0.1, 0.1)  # Cor da malha
var x_axis_color: Color = Color(1, 0, 0)  # Cor do eixo X (vermelho)
var y_axis_color: Color = Color(0, 1, 0)  # Cor do eixo Y (verde)

@export var custom_font: Font  # Usando a nova classe Font

func _ready() -> void:
	if custom_font == null:
		push_error("Nenhuma fonte foi atribuída!")
	queue_redraw()  # Solicita o redesenho da tela quando a cena é carregada

func _draw() -> void:
	draw_grid()  # Desenha a malha e os eixos
	draw_numbers()  # Desenha os números nos eixos

# Função para desenhar a malha
func draw_grid() -> void:
	var size = get_viewport_rect().size
	for x in range(0, int(size.x), grid_size):
		draw_line(Vector2(x, 0), Vector2(x, size.y), grid_color)
	for y in range(0, int(size.y), grid_size):
		draw_line(Vector2(0, y), Vector2(size.x, y), grid_color)

	var center = Vector2(size.x / 2, size.y / 2)
	draw_line(Vector2(center.x, 0), Vector2(center.x, size.y), y_axis_color)
	draw_line(Vector2(0, center.y), Vector2(size.x, center.y), x_axis_color)

# Função para desenhar a numeração dos eixos X e Y
func draw_numbers() -> void:
	var size = get_viewport_rect().size
	var center = Vector2(size.x / 2, size.y / 2)

	if custom_font == null:
		push_error("Nenhuma fonte foi atribuída!")
		return

	# Desenha os números no eixo X
	for i in range(-int(size.x / (2 * grid_size)), int(size.x / (2 * grid_size)) + 1):
		if i != 0:
			var x_position = center.x + i * grid_size
			# Ajuste a posição vertical dos números
			draw_string(custom_font, Vector2(x_position, center.y + 15), str(i), HORIZONTAL_ALIGNMENT_CENTER)

	# Desenha os números no eixo Y
	for i in range(-int(size.y / (2 * grid_size)), int(size.y / (2 * grid_size)) + 1):
		if i != 0:
			var y_position = center.y - i * grid_size
			draw_string(custom_font, Vector2(center.x + 5, y_position), str(i), HORIZONTAL_ALIGNMENT_CENTER)

func _process(delta: float) -> void:
	queue_redraw()  # Redesenha a cada frame
