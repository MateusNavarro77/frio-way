extends CanvasLayer


func _on_button_pressed() -> void:
	var tree =get_tree()
	#tree.change_scene_to_file("res://cenas/main.tscn")
	tree.reload_current_scene()
	pass # Replace with function body.
