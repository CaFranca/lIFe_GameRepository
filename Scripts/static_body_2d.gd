extends StaticBody2D

# Variáveis para controlar o movimento
var speed: float = 200.0 # Velocidade da plataforma
var has_moved: bool = false # Controla se a plataforma já se moveu
var appearance_count: int = 0 # Contador para quantas vezes a plataforma apareceu

# Referências aos nós da cena
onready var collision_shape = $CollisionShape2D
onready var timer = $Timer 
onready var sprite = $Sprite # Supondo que você tenha um Sprite para a plataforma

func _ready() -> void:
	collision_shape.set_deferred("disabled", false) # Habilita a colisão
	timer.start() # Inicia o timer

func _process(delta: float) -> void:
	if has_moved:
		return # Não faz nada se a plataforma já se moveu

	# Move a plataforma da direita para a esquerda
	position.x -= speed * delta
	
	# Verifica se a plataforma saiu da tela
	if position.x < -200:
		has_moved = true # A plataforma já se moveu uma vez
		hide() # Esconde a plataforma

# Função chamada quando o Timer acaba
func _on_Timer_timeout() -> void:
	if appearance_count < 3: # Verifica se a plataforma já apareceu 3 vezes
		position.x = 800 # Reposiciona a plataforma (ajuste conforme necessário)
		has_moved = false # Permite que a plataforma se mova novamente
		show() # Mostra a plataforma
		timer.start() # Reinicia o timer
		appearance_count += 1 # Incrementa o contador
