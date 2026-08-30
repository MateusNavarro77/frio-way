extends CanvasLayer



func _on_button_pressed() -> void:
	var tree =get_tree()
	#tree.change_scene_to_file("res://cenas/main.tscn")
	tree.reload_current_scene()
	pass # Replace with function body.


func _on_pontua(pontuacao: int) -> void:
	$Placar.text = str(pontuacao)


func _on_pontua_p2(pontuacao: int) -> void:
	$Placar2.text = str(pontuacao)


func _atualizar_vidas_p1(n_vidas: int) -> void:
	$VidasP1.text = "P1: " + str(n_vidas)


func _atualizar_vidas_p2(n_vidas: int) -> void:
	$VidasP2.text = "P2: " + str(n_vidas)


func _atualizar_tempo_restante(tempo_restante: int) -> void:
	$TempoRestante.text = 'Tempo restante: ' + str(tempo_restante)
