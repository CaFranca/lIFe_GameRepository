extends Node

func generate_operation() -> Dictionary:
	var a = randi() % 10
	var b = randi() % 10
	var operation_type = randi() % 2  # 0 para soma, 1 para subtração

	var question = ""
	var answer = 0

	if operation_type == 0:
		question = "%d + %d = ?" % [a, b]
		answer = a + b
	else:
		# Garante que o resultado não seja negativo
		if a < b:
			var temp = a
			a = b
			b = temp
		question = "%d - %d = ?" % [a, b]
		answer = a - b

	return {
		"question": question,
		"answer": answer
	}
