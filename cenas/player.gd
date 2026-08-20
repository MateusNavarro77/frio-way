extends Area2D
#posicionar
signal pontua
@export var speed: float = 100.0 #100 pixels por segundo
var posicao_inicial: Vector2 = Vector2(640,690)
var screen_size: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	position = posicao_inicial
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vetor_velocidade = Vector2.ZERO
	
	if(Input.is_action_pressed("ui_up")):
		vetor_velocidade.y -=1
	
	if(Input.is_action_pressed("ui_down")):
		vetor_velocidade.y +=1
	
	if(vetor_velocidade !=Vector2.ZERO):
		vetor_velocidade = vetor_velocidade.normalized()*speed
	
	position +=vetor_velocidade*delta
	position.y = clamp(position.y,0.0,screen_size.y)
	
	if(vetor_velocidade.y > 0):
		$Animacao.play("baixo")

	elif(vetor_velocidade.y<0):
		$Animacao.play("cima")

	else:
		$Animacao.stop()
		

func somaDoida(a:float,b:float) -> float:
		return a+b


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "LinhaChegada"):
		emit_signal("pontua")
		return
	$Audio.play()
	position = posicao_inicial
