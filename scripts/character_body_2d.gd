extends CharacterBody2D
@onready var player_animation = $player_animation

const SPEED = 150.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("right")||Input.is_action_pressed("left"):
		direction.y=0
	elif Input.is_action_pressed("up")||Input.is_action_pressed("down"):
		direction.x=0
	else:
		direction = Vector2.ZERO
		$AnimatedSprite2D.play("idle_down")
			
		
	direction = direction.normalized()
	velocity = (direction*SPEED)
	
	move_and_slide()
	
	if direction != Vector2.ZERO:
		if Input.is_action_just_pressed("ui_left"):
			$AnimatedSprite2D.play("walk_left")

		if Input.is_action_just_pressed("ui_right"):
			$AnimatedSprite2D.play("walk_right")

		if Input.is_action_just_pressed("ui_up"):
			$AnimatedSprite2D.play("walk_up")

		if Input.is_action_just_pressed("ui_down"):
			$AnimatedSprite2D.play("walk_down")
			

	
	
