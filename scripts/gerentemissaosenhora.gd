extends Node

var missao_ativa = false
var missao_completa = false
var moedas_coletadas = 0
var moedas_finais = 4

signal missao_iniciada

func inicia_missao():
	missao_ativa = true
	missao_completa = false
	moedas_coletadas = 0
	emit_signal("missao_iniciada")

func coleta_moeda_missao():
	if missao_ativa && not missao_completa:
		moedas_coletadas += 1
		if moedas_coletadas >= moedas_finais:
			completando_missao()

func completando_missao():
	missao_completa = true
	missao_ativa = false
