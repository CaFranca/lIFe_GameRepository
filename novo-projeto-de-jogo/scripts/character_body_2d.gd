extends CharacterBody2D

const SPEED = 200.0  # Velocidade do personagem
const JUMP_HEIGHT = 50  # Altura do pulo (em pixels)
const JUMP_SPEED = 150.0  # Velocidade do pulo (subida e descida)

@onready var animation := $AnimatedSprite2D  # Referência ao AnimatedSprite2D

var is_jumping := false  # Indica se o personagem está pulando
var jump_start_y := 0  # Posição inicial do pulo
var jump_peak_reached := false  # O personagem atingiu o topo do pulo?
var jump_velocity := 0  # Controle separado do pulo

func _physics_process(delta: float) -> void:
	# Adiciona suporte para WASD além das setas
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x == 0:  
		direction_x = -1 if Input.is_key_pressed(KEY_A) else 1 if Input.is_key_pressed(KEY_D) else 0

	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y == 0:  
		direction_y = -1 if Input.is_key_pressed(KEY_W) else 1 if Input.is_key_pressed(KEY_S) else 0

	var jump := Input.is_action_just_pressed("ui_accept")  # Botão de pulo

	# Iniciar o pulo
	if jump and not is_jumping:
		is_jumping = true
		jump_start_y = position.y
		jump_peak_reached = false
		jump_velocity = -JUMP_SPEED  # Começa subindo
		animation.play("Jump")

	# Controle do pulo
	if is_jumping:
		position.y += jump_velocity * delta  # Aplica a velocidade do pulo
		if not jump_peak_reached:
			if position.y <= jump_start_y - JUMP_HEIGHT or is_on_ceiling():
				jump_peak_reached = true  # Chegou no topo ou bateu no teto
				jump_velocity = JUMP_SPEED  # Inicia a descida
		else:
			if position.y >= jump_start_y or is_on_floor():
				position.y = jump_start_y  # Corrige a posição
				is_jumping = false  # Termina o pulo
				jump_velocity = 0  # Para a movimentação vertical do pulo

	# Movimento horizontal (pode andar enquanto pula)
	if direction_x != 0:
		velocity.x = direction_x * SPEED
		$AnimatedSprite2D.flip_h = direction_x < 0  # Vira o sprite corretamente
	else:
		velocity.x = 0

	# Movimento vertical (se não estiver pulando)
	if not is_jumping:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = 0  # Impede que a movimentação vertical interfira no pulo

	# Lógica de animação
	if not is_jumping:
		if direction_x != 0:
			animation.play("Run")
		elif direction_y < 0:
			animation.play("Run_Up")
		elif direction_y > 0:
			animation.play("Run_Down")
		else:
			animation.play("Idle")

	move_and_slide()
