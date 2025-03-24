extends Control

@onready var contadormoeda = $container/moedacontainer/contadormoeda as Label
@onready var contadortime = $container/timercontainer/contadortime as Label
@onready var clock_timer = $clock_timer as Timer
@onready var fade_in := $fade_in as Timer
@onready var fade_out := $fade_in/fade_out as Timer
@onready var transicao := $ColorRect
@onready var animacao := $"transição/ColorRect/animaçao"
@onready var mudar_cena := $fade_in/mudar_cena as Timer

var minutos = 0
var segundos = 0
@export_range(0, 23) var default_minutos := 1  # Tempo inicial em minutos
@export_range(0, 59) var default_segundos := 0  # Tempo inicial em segundos
@export var scene_to_load: String = "res://cenas/conceicao"  # Caminho da nova cena

# Chamado quando o nó entra na árvore da cena pela primeira vez
func _ready():
	contadormoeda.text = str(Tudo.moeda)
	reset_clock_timer()

# Chamado a cada frame
func _process(delta):
	contadormoeda.text = str(Tudo.moeda)

# Chamado quando o clock_timer dá timeout (a cada intervalo definido)
func _on_clock_timer_timeout():
	if segundos == 0:  # Se os segundos chegaram a 0
		if minutos > 0:  # Se ainda há minutos
			minutos -= 1
			segundos = 59  # Reseta os segundos para 59
		else:
			end_game()  # Se não há mais minutos, encerra o jogo
	else:
		segundos -= 1  # Decrementa os segundos

	# Atualiza o display do timer
	contadortime.text = str("%02d" % minutos) + ":" + str("%02d" % segundos)

# Função para resetar o timer para os valores padrões
func reset_clock_timer():
	minutos = default_minutos
	segundos = default_segundos
	contadortime.text = str("%02d" % minutos) + ":" + str("%02d" % segundos)
	
	# Certifique-se de que o timer está configurado para acionar a cada 1 segundo
	clock_timer.wait_time = 1  # Define o tempo de espera como 1 segundo
	clock_timer.start()  # Inicia o timer

# Função para encerrar o jogo
func end_game():
	if segundos == 0 and minutos == 0:
		
		# Muda para a nova cena
		
		print("Mudando para a nova cena!")
		get_tree().change_scene_to_file("res://cenas/Conceicao.tscn") # Altera a cena para a especificada
