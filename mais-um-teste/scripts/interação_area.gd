extends Area2D
class_name InteraçãoArea

@export var nome_da_ação: String = "Interaja"

var interagir: Callable = func():
	pass 


func _on_body_entered(body: Node2D) -> void:
	GerenteInteracao.registra_area(self)


func _on_body_exited(body: Node2D) -> void:
	GerenteInteracao.area_nao_registrada(self)
