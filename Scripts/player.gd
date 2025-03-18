extends CharacterBody2D

var grav = 10 #define gravidade para o personagem
var vel = 150 #define velocidade para o personagem

func _process(delta): #executa os processos 60 vezes p/s
	
	if !is_on_floor():
		velocity.y += grav #velocity.y controla a força y
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = vel  #velocity.x controla a força x
		$Sprite2D.flip_h = false #rotação personagem de acordo com a direção
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -vel
		$Sprite2D.flip_h = true
	
	else:
		velocity.x = 0
	
	#configurar pulo do player
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y -= 200
				
		
	move_and_slide()
	apply_push_force()

func apply_push_force():
	for objects in get_slide_collision_count():
		var collision = get_slide_collision(objects)
		if collision.get_collider() is Pushables:
			collision.get_collider().slide_object(-collision.get_normal())
