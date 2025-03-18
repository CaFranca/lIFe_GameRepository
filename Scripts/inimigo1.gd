extends CharacterBody2D  # Usamos CharacterBody2D para controlar o movimento do inimigo.

# Variáveis principais
var speed = 50  # Velocidade do inimigo
var direction = Vector2(-1, 0)  # Direção inicial (indo para a esquerda)
var gravity = 500  # Gravidade aplicada ao inimigo

# Referências para o AnimatedSprite2D e RayCast2D
@onready var sprite = $AnimatedSprite2D  # Acessa o nó AnimatedSprite2D
@onready var wall_ray = $RayCast2D  # Acessa o nó RayCast2D

# Função que é chamada a cada frame
func _physics_process(delta):
	
	# Aplicar gravidade constante no inimigo
	velocity.y += gravity * delta

	# Movimento horizontal na direção atual
	velocity.x = direction.x * speed
	
	# Move o inimigo e lida com colisões
	move_and_slide()
	
	# Se o RayCast2D detectar uma colisão, inverte a direção
	if wall_ray.is_colliding():
		direction.x *= -1  # Inverte a direção horizontal
		sprite.flip_h = !sprite.flip_h  # Espelha o sprite para a direção oposta

	if direction.x == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
