extends Camera2D

# Limites do cenário
var left_limit = 0
var right_limit = 2000
var top_limit = 0
var bottom_limit = 1200


func _process(delta):
	# Seguir o jogador
	var player = get_node("/root/Player")  # Substitua com o caminho correto do jogador
position = player.position

	# Limitar os movimentos da câmera
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, top_limit, bottom_limit)
