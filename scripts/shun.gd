extends Node2D

@onready var interação_area: InteraçãoArea = $"interação_area"
@export var jogador = CharacterBody2D

const fala: Array[String] = [
	"Hmm... Oi (?)",
	"Você viu que saiu o resultado da 5ª fase da OBMEP?",
	"*eiπ+1=0",
	"Tô indo alí tocar um...",
	"METAL BRUTAL!!!",
	"Quer me acompanhar na aula de baixo?"
]


func _ready() -> void:
	interação_area.interagir = Callable(self, "interagindo")
	
func interagindo():
	Gerentedialogo.inicia_dialogo(global_position, fala)
	await Gerentedialogo.dialogo_acaba
