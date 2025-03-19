extends CharacterBody2D

const SPEED = 200.0  # Velocidade do personagem
const JUMP_VELOCITY = -300.0  # Velocidade do pulo (não será usado com gravidade apenas para mover no chão)
const GRAVITY = 1000.0  # Gravidade aplicada ao personagem

@onready var animation := $AnimatedSprite2D  # Referência ao AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Movimentação livre no eixo Y (vertical) e X (horizontal)
	var direction_x := Input.get_axis("ui_left", "ui_right")  # Movimento horizontal
	var direction_y := Input.get_axis("ui_up", "ui_down")  # Movimento vertical

	# Movimentação horizontal (esquerda/direita)
	if direction_x != 0:
		velocity.x = direction_x * SPEED  # Aplica a velocidade de movimento horizontal
		# Animações de movimento horizontal
		if direction_x < 0:
			$AnimatedSprite2D.flip_h = true  # Vira o sprite para a esquerda
			animation.play("Run")  # Animação de correr para esquerda
		else:
			$AnimatedSprite2D.flip_h = false  # Vira o sprite para a direita
			animation.play("Run")  # Animação de correr para direita
	# Movimentação vertical (cima/baixo)
	elif direction_y != 0:
		velocity.y = direction_y * SPEED  # Aplica a velocidade de movimento vertical
		# Animações de movimento vertical
		if direction_y < 0:
			animation.play("Run_Up")  # Animação de correr para cima
		else:
			animation.play("Run_Down")  # Animação de correr para baixo
	else:
		# Quando não há movimento, desacelera suavemente até parar
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animation.play("Idle")  # Animação de ficar parado

	# Aplicar a física de movimento (horizontal + gravidade no eixo Y)
	# Como o personagem vai se mover apenas em 2D, a gravidade é aplicada apenas no eixo Y
	

	move_and_slide()  # O vetor UP garante que a gravidade seja aplicada corretamente
