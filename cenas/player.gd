extends Area2D
#posicionar
signal pontua
signal morreu
@export var speed: float = 200.0 #100 pixels por segundo
var posicao_inicial: Vector2 = Vector2(640,690)
var screen_size: Vector2

@onready var audio1 : AudioStreamPlayer2D= $AudioPopo1
@onready var audio2 : AudioStreamPlayer2D= $AudioPopo2
@onready var audio3: AudioStreamPlayer2D = $AudioPopo3
@onready var audios : Array[AudioStreamPlayer2D]= [audio1,audio2,audio3]
const TEMPO_ENTRE_POPOS: float = 10

var tempo_passado=0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	position = posicao_inicial
	$Animacao.play("cima")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vetor_velocidade = Vector2.ZERO
	
	
	var passou_tempo = checar_tempo(delta)
	if(passou_tempo):
		tocar_popo_da_galinha()
	
	
	if(Input.is_action_pressed("ui_up")):
		vetor_velocidade.y -=1
	
	if(Input.is_action_pressed("ui_down")):
		vetor_velocidade.y +=1
		
	if(Input.is_action_pressed("ui_right")):
		vetor_velocidade.x +=1
	
	if(Input.is_action_pressed("ui_left")):
		vetor_velocidade.x -=1
	
	if(vetor_velocidade !=Vector2.ZERO):
		vetor_velocidade = vetor_velocidade.normalized()*speed
	
	position +=vetor_velocidade*delta
	position.y = clamp(position.y,0.0,screen_size.y)
	position.x = clamp(position.x,0.0,screen_size.x)
	
	if(vetor_velocidade.y > 0):
		$Animacao.play("baixo")

	elif(vetor_velocidade.y<0):
		$Animacao.play("cima")
		
	elif(vetor_velocidade.x<0):
		$Animacao.play("esquerda")
	elif(vetor_velocidade.x>0):
		$Animacao.play("direita")

	else:
		$Animacao.stop()
		

func somaDoida(a:float,b:float) -> float:
		return a+b

func checar_tempo(delta:float) -> bool:
	tempo_passado += delta
	if(tempo_passado>=TEMPO_ENTRE_POPOS):
		tempo_passado = 0
		return true
	return false
	
	
func _on_body_entered(body: Node2D) -> void:
	if (body.name == "LinhaChegada"):
		emit_signal("pontua")
		$Audio.play()
		position = posicao_inicial
		return
	emit_signal("morreu")
	$AudioMorreu.play()
	position = posicao_inicial
	
func tocar_popo_da_galinha():
	var indice_escolhido = randi_range(0,audios.size()-1)
	var popo = audios[indice_escolhido]
	popo.play()

	pass
