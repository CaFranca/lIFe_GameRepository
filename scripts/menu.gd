extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Encontrar todos os botões no grupo "button" e conectar sinais
	for button in get_tree().get_nodes_in_group("button"):
		if button is Button:  # Verifica se o nó é do tipo Button
			# Conectando o sinal "pressed" do botão à função "_on_button_pressed"
			button.connect("pressed", Callable(self, "_on_button_pressed").bind(button))
			# Conectando o sinal "mouse_entered" do botão à função "_on_mouse_entered"
			button.connect("mouse_entered", Callable(self, "_on_mouse_entered").bind(button))
			# Conectando o sinal "mouse_exited" do botão à função "_on_mouse_exited"
			button.connect("mouse_exited", Callable(self, "_on_mouse_exited").bind(button))

# Função chamada quando um botão é pressionado
func _on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			# Carregar a cena de gameplay e trocar para ela
			var gameplay_scene = load("res://scenes/gameplay.tscn") as PackedScene
			get_tree().change_scene_to(gameplay_scene)
		"ConfigureMic":
			# Carregar a cena de configuração de microfone e trocar para ela
			var config_scene = load("res://scenes/interface/config_screen.tscn") as PackedScene
			get_tree().change_scene_to(config_scene)
		"Controls":
			# Carregar a cena de controles e trocar para ela
			var controls_scene = load("res://scenes/interface/controls.tscn") as PackedScene
			get_tree().change_scene_to(controls_scene)
		"CaVibezz":
			# Abrir o link do YouTube
			OS.shell_open("https://www.youtube.com/@CaVibezz")
		"Quit":
			# Sair do jogo
			get_tree().quit()
		_:
			# Caso o nome do botão não seja conhecido
			print("Botão desconhecido pressionado: ", button.name)

# Função chamada quando o mouse entra no botão
func _on_mouse_entered(button: Button) -> void:
	# Lógica para quando o mouse entra no botão
	button.modulate.a= 1.0
	print(button.name, " mouse entrou.")

# Função chamada quando o mouse sai do botão
func _on_mouse_exited(button: Button) -> void:
	# Lógica para quando o mouse sai do botão
	button.modulate.a= 0.5
	print(button.name, " mouse saiu.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
