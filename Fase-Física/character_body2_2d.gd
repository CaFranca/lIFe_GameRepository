extends CharacterBody2D

var speed = 450
var JUMP_VELOCITY = -1000
var player_velocity = Vector2()

@onready var animation_scene = preload("res://Animation.tscn")  # Caminho correto para a cena
var texture  # Variável para o AnimationPlayer

func _ready():
	add_to_group("Player")
	
	# Instancia e adiciona a cena de animação
	var animation_instance = animation_scene.instantiate()
	add_child(animation_instance)
	
	# Referência para o AnimationPlayer
	texture = animation_instance.get_node("AnimationPlayer")
	
	# Verificação para garantir que a referência está funcionando
	if texture:
		print("AnimationPlayer encontrado!")
	else:
		print("AnimationPlayer não encontrado.")

func _physics_process(_delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		$Sprite2D.flip_h = true
		if texture and texture.has_animation("Walk"):  # Verifica se a animação existe
			texture.play("Walk")
	elif Input.is_action_pressed("ui_right"):
		direction += 1
		$Sprite2D.flip_h = false
		if texture and texture.has_animation("Walk"):  # Verifica se a animação existe
			texture.play("Walk")
	else:
		if texture and texture.is_playing():
			texture.stop()  # Para a animação caso o jogador pare de andar

	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y += 40  # Aplica gravidade
	move_and_slide()
