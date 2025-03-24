extends Node2D

@onready var interação_area: InteraçãoArea = $"interação_area"
@export var jogador = CharacterBody2D

const fala: Array[String] = [
	"*bzz bzz*",
	"Opa!",
	"Aqui ferrou, tá?",
	"Cê sabe como faz pra ir até a linha coral? Tô meio perdido...",
	"*bzz bzz*"
]


func _ready() -> void:
	interação_area.interagir = Callable(self, "interagindo")
	
func interagindo():
	Gerentedialogo.inicia_dialogo(global_position, fala)
	await Gerentedialogo.dialogo_acaba
