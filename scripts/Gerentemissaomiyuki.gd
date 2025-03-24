extends Node

var missao_ativa = false
var missao_completa = false
var pendrives_coletados = 0
var pendrives_finais = 1

signal missao_iniciada

func inicia_missao():
	missao_ativa = true
	missao_completa = false
	pendrives_coletados = 0
	emit_signal("missao_iniciada")

func coleta_pendrive_missao():
	if missao_ativa && not missao_completa:
		pendrives_coletados += 1
		print("Pendrives coletados:", pendrives_coletados)  # Adicione esta linha para depuração
	if pendrives_coletados >= pendrives_finais:
		completando_missao()


func completando_missao():
	missao_completa = true
	missao_ativa = false
