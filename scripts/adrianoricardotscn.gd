extends Node2D

@onready var interação_area: InteraçãoArea = $"interação_area"
@export var jogador = CharacterBody2D

const fala: Array[String] = [
	"Aaaannnn...",
	"OPA >.<",
	"Meu nome é Adriano Ricardo, mas pode me chamar de Ricaridnho.",
	"Estou indo para o IF. quer vir comigo?",
	"*cof cof*"
]


func _ready() -> void:
	interação_area.interagir = Callable(self, "interagindo")
	
func interagindo():
	Gerentedialogo.inicia_dialogo(global_position, fala)
	await Gerentedialogo.dialogo_acaba
