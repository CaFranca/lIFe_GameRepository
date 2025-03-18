extends CharacterBody2D
class_name Pushables

const PUSH_SPEED = 200.0 #define velocidade

var gravity = 10 #define gravidade

func _physics_process(delta):
	velocity.y += gravity
	
	move_and_slide()
	
	velocity.x = 0 # Zera o movimento lateral

	
func slide_object(direction):
	velocity.x = int(direction.x) * PUSH_SPEED
