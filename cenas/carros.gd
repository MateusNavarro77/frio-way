extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprites_dos_carros = $Animacao.sprite_frames.get_animation_names()
	var indice_escolhido = randi_range(0,sprites_dos_carros.size()-1)
	var carro = sprites_dos_carros[indice_escolhido]
	$Animacao.animation = carro
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_notificador_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
