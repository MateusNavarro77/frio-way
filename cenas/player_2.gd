extends Area2D
#posicionar
signal pontua_p2
signal morreu_p2
@export var speed: float = 200.0 #100 pixels por segundo
var posicao_inicial: Vector2 = Vector2(680,690)
var screen_size: Vector2

#@onready var audio1 : AudioStreamPlayer2D= $AudioPopo1
#@onready var audio2 : AudioStreamPlayer2D= $AudioPopo2
#@onready var audio3: AudioStreamPlayer2D = $AudioPopo3
#@onready var audios : Array[AudioStreamPlayer2D]= [audio1,audio2,audio3]
#const TEMPO_ENTRE_POPOS: float = 10
#
#var tempo_passado=0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	position = posicao_inicial
	$Animacao.play("cima")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vetor_velocidade = Vector2.ZERO
	
	
	#var passou_tempo = checar_tempo(delta)
	#if(passou_tempo):
		#tocar_popo_da_galinha()
	
	
	if Input.is_key_pressed(KEY_W):
		vetor_velocidade.y -= 1
	
	if Input.is_key_pressed(KEY_S):
		vetor_velocidade.y += 1
		
	if Input.is_key_pressed(KEY_D):
		vetor_velocidade.x += 1
	
	if Input.is_key_pressed(KEY_A):
		vetor_velocidade.x -= 1
	
	if(vetor_velocidade !=Vector2.ZERO):
		vetor_velocidade = vetor_velocidade.normalized()*speed
	
	var outro_player: Node2D = get_parent().get_node_or_null("Player") if get_parent() else null
	const RAIO_COLISAO: float = 14.0
	
	var movimento = vetor_velocidade * delta
	
	if outro_player and is_instance_valid(outro_player):
		var pos_futura_x = position + Vector2(movimento.x, 0)
		var dist_atual = position.distance_to(outro_player.position)
		var dist_futura_x = pos_futura_x.distance_to(outro_player.position)
		
		# Só bloqueia no X se estiver no limite de colisão E o movimento for aproximar ainda mais
		if dist_futura_x < RAIO_COLISAO and dist_futura_x < dist_atual:
			movimento.x = 0
		
		position.x += movimento.x
		position.x = clamp(position.x, 0.0, screen_size.x)
		
		var pos_futura_y = position + Vector2(0, movimento.y)
		dist_atual = position.distance_to(outro_player.position)
		var dist_futura_y = pos_futura_y.distance_to(outro_player.position)
		
		# Só bloqueia no Y se estiver no limite de colisão E o movimento for aproximar ainda mais
		if dist_futura_y < RAIO_COLISAO and dist_futura_y < dist_atual:
			movimento.y = 0
			
		position.y += movimento.y
		position.y = clamp(position.y, 0.0, screen_size.y)
	else:
		position += movimento
		position.x = clamp(position.x, 0.0, screen_size.x)
		position.y = clamp(position.y, 0.0, screen_size.y)
	
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


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "LinhaChegada"):
		emit_signal("pontua_p2")
		$Audio.play()
		position = posicao_inicial
		return
	emit_signal("morreu_p2")
	$AudioMorreu.play()
	position = posicao_inicial
	
#func tocar_popo_da_galinha():
	#var indice_escolhido = randi_range(0,audios.size()-1)
	#var popo = audios[indice_escolhido]
	#popo.play()
#
	#pass
