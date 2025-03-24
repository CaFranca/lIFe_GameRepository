extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const texto_basico_interação = "Interage ai vai [E]"

var area_ativa_interação = []
var pode_interagir = true


func registra_area(area: InteraçãoArea):
	area_ativa_interação.push_back(area)
	
func area_nao_registrada(area = InteraçãoArea):
	var index = area_ativa_interação.find(area)
	if index != -1:
		area_ativa_interação.remove_at(index)



func _process(_delta):
	if area_ativa_interação.size() > 0 && pode_interagir:
		area_ativa_interação.sort_custom(organizar_pela_distancia)
		label.text = texto_basico_interação + area_ativa_interação[0].nome_da_ação
		label.global_position = area_ativa_interação[0].global_position
		label.global_position.y -= 36 
		label.global_position.x -= label.size.x / 2  
		label.show()
	else:
		label.hide()




func organizar_pela_distancia(area1, area2):
	var area1_distancia = player.global_position.distance_to(area1.global_position)
	var area2_distancia = player.global_position.distance_to(area2.global_position)
	return area1_distancia > area2_distancia


func _input(event):
	if event.is_action_pressed("Interagir"):
		if area_ativa_interação.size() > 0:
			pode_interagir = false
			label.hide()
			
			await area_ativa_interação[0].interagir.call()
			pode_interagir = true
