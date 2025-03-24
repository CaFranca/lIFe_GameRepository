extends Node2D

@onready var fade_in := $fade_in as Timer
@onready var fade_out := $fade_in/fade_out as Timer
@onready var transicao := $ColorRect
@onready var animacao := $"transição/ColorRect/animaçao"
@onready var mudar_cena := $fade_in/mudar_cena as Timer

func _ready() -> void:
	$tvzinha.play()
	$tvzinha2.play()
	fade_in.start()
	
	

func _process(delta: float) -> void:
	pass


func _on_tempo_timeout() -> void:
	animacao.play("fade_in")
	fade_out.start()
	print("Próxima estação: Conceição")



func _on_fade_out_timeout() -> void:
	animacao.play("fade_out")
