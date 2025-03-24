extends Node2D

@onready var interação_area: InteraçãoArea = $"interação_area"
@export var jogador = CharacterBody2D

const fala: Array[String] = [
	"Eai, cara! Eu sou o Penso.",
	"Você ouviu o novo albúm do...",
	"TYLER, THE CREATOR???",
	"Bro, ficou sabendo do caso do P. Diddy!!??"
	
]


func _ready() -> void:
	interação_area.interagir = Callable(self, "interagindo")
	
func interagindo():
	Gerentedialogo.inicia_dialogo(global_position, fala)
	await Gerentedialogo.dialogo_acaba
