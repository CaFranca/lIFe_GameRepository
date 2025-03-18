extends CharacterBody2D

var speed = 350
var JUMP_VELOCITY = -600
var player_velocity = Vector2()

func _ready():
	add_to_group("player")  # Adiciona o personagem ao grupo "player"

func _physics_process(_delta):
	# Controle de movimento lateral
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_right"):
		direction += 1
		$Sprite2D.flip_h = false
		
	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y += 13  # Aplica gravidade
	move_and_slide() 

	# Verificação de limites
	if position.x < 0:
		position.x = 0
	var screen_width = get_viewport().size.x
	if position.x >= screen_width - 300:
		position.x = screen_width - 300
