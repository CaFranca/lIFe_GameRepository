extends Node2D

@onready var generator = $OperationGenerator
@onready var question_label = $QuestionLabel
@onready var input_field = $InputField
@onready var submit_button = $SubmitButton

var falling_question_scene = preload("res://scenes/FallingQuestion.tscn")
var active_questions = []  # lista de contas caindo

func _ready():
	randomize()
	_on_spawn_timer_timeout()
	submit_button.pressed.connect(_on_submit_pressed)
	input_field.text_submitted.connect(_on_input_submitted)

func generate_new_question():
	var operation = generator.generate_operation()
	var falling_question = falling_question_scene.instantiate()
	falling_question.question = operation["question"]
	falling_question.answer = operation["answer"]
	falling_question.position = Vector2(randi() % 400 + 100, 0)  # posição X aleatória
	falling_question.connect("question_failed", _on_question_failed.bind(falling_question))
	add_child(falling_question)
	active_questions.append(falling_question)

	question_label.text = "Responda a operação correta!"
	input_field.text = ""
	input_field.grab_focus()

func _on_submit_pressed():
	check_answer()

func _on_input_submitted(_new_text):
	check_answer()

func check_answer():
	if input_field.text.strip_edges() == "":
		return

	var player_answer = int(input_field.text)
	var found = false

	for q in active_questions:
		if is_instance_valid(q) and not q.answered and player_answer == q.answer:
			q.answered = true
			q.queue_free()
			active_questions.erase(q)
			question_label.text = "Correto!"
			found = true
			break

	if not found:
		question_label.text = "Nenhuma operação corresponde."

	input_field.text = ""

func _on_question_failed(failed_question):
	if active_questions.has(failed_question):
		active_questions.erase(failed_question)
	question_label.text = "Uma conta caiu sem resposta!"


func _on_spawn_timer_timeout() -> void:
	generate_new_question()
