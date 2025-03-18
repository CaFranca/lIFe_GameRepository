extends CharacterBody2D  # Usamos CharacterBody2D para controlar o movimento do personagem.

# Definindo variáveis principais
var speed = 200  # Velocidade máxima do personagem (em pixels por segundo).
var gravity = 500  # Força gravitacional aplicada ao personagem.
var jump_force = -300  # Força do pulo (negativo porque no eixo Y, o topo é negativo).
var is_on_ground = false  # Checa se o personagem está no chão.

# Referência para o AnimatedSprite2D
@onready var sprite = $AnimatedSprite2D  # Acessa o nó AnimatedSprite2D

# Função que é chamada a cada frame
func _physics_process(delta):
	# Checando se o personagem está no chão para permitir pulo
	is_on_ground = is_on_floor()

	# Reiniciamos a velocidade horizontal (eixo X) a cada frame
	velocity.x = 0

	# Movimento lateral usando as setas do teclado
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed  # Move para a direita
		$AnimatedSprite2D.flip_h = false #rotação personagem de acordo com a direção
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed  # Move para a esquerda
		$AnimatedSprite2D.flip_h = true

	# Pular se a tecla de pulo for pressionada e o personagem estiver no chão
	if is_on_ground and Input.is_action_just_pressed("ui_select"):
		velocity.y = jump_force  # Aplicamos a força do pulo

	# Aplicar gravidade constante se o personagem não estiver no chão
	if not is_on_ground:
		velocity.y += gravity * delta

	# Controlando o sprite baseado no estado do personagem
	if is_on_ground:
		if velocity.x != 0:
			sprite.play("")  # Toca a animação de corrida se estiver se movendo
		else:
			sprite.play("padrao")  # Toca a animação padrão (piscando), enquanto ele estiver parado
	else:
		sprite.play("pulo")  # Toca a animação de pulo enquanto no ar
		
	# Mover o personagem com move_and_slide(), que lida com colisões
	move_and_slide()
