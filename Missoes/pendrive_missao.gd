extends Area2D

var pendrive := 1

func _ready() -> void:
	print("Pendrive script loaded")
	# Verifique se o Gerente de Missão é o correto
	if Gerentemissaomiyuki:
		Gerentemissaomiyuki.connect("missao_iniciada", Callable(self, "_com_missao_iniciada"))
		print("Conexão com missao_iniciada feita")
	else:
		print("Gerente de Missão não encontrado")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		for i in range(10):
			modulate.a -= 0.25
			await get_tree().create_timer(0.1).timeout
		await $CollisionShape2D.call_deferred("queue_free")
		Tudo.pendrive += pendrive
		print("Pendrive coletado")
		if Gerentemissaomiyuki.missao_ativa:
			Gerentemissaomiyuki.coleta_pendrive_missao()
		
		queue_free()

func _com_missao_iniciada():
	print("Missão da Miyuki iniciada, pendrive agora visível")
	visible = true
	$CollisionShape2D.disabled = false
