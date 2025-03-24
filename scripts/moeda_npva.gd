extends Area2D

var moeda := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Gerentemissaosenhora.connect("missao_iniciada", Callable(self, "_com_missao_iniciada"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Verifica se quem tocou é o jogador
		$moedaaudio.play()  # Toca o som
		# Diminui a opacidade da moeda enquanto o som toca
		for i in range(10):  # Loop para reduzir a opacidade em 10 etapas
			modulate.a -= 0.25  # Reduz a opacidade
			await get_tree().create_timer(0.1).timeout 
		await $CollisionShape2D.call_deferred("queue_free")
		Tudo.moeda += moeda
		print(Tudo.moeda)
		
		if Gerentemissaosenhora.missao_ativa:
			Gerentemissaosenhora.coleta_moeda_missao()
		
		queue_free()  # Remove a moeda
func _com_missao_iniciada():
	visible = true
	$CollisionShape2D.disabled = false
