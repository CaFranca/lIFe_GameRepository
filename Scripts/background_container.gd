extends ParallaxBackground

var speed = 200  # Ajuste a velocidade conforme necessário

func _process(delta):
	# Move a imagem de fundo para a esquerda
	offset.x -= speed * delta
