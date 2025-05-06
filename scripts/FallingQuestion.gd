extends Node2D

var question = ""
var answer = 0
var speed = 250.0
var answered = false

signal question_failed

@onready var label = $Label
@onready var area = $Area2D  # acessa o Area2D para conectar

func _ready():
	label.text = question
	area.body_entered.connect(_on_Area2D_body_entered)  # conecta o sinal manualmente aqui

func _process(delta):
	if not answered:
		position.y += speed * delta

func _on_Area2D_body_entered(body):
	if not answered:
		emit_signal("question_failed")
		queue_free()
