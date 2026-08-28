extends Node


var cena_carros = preload("res://cenas/carros.tscn")
var cena_onibus = preload("res://cenas/onibus.tscn")
var cena_bicicleta = preload("res://cenas/bicicleta.tscn")
## FAiXAS novas
## 117 onibus
## 183 carro
## 240 carro
## 287 carro
## 338 bicicleta
## 367 bicicleta
## 423 carro
## 480 carro
## 540 carro
## 604 onibus
var pistas_rapidas_y = [183,287,480]
var faixas_de_onibus = [117,604]
var pistas_lentas_y = [160,216,324,384,438,544,600]
var origem_carros_x_esquerda = -10
var origem_carros_x_direita = 1290
var velocidade_dos_rapidos = 700
var velocidade_onibus = 400.0
var velocidade_bicicleta = 200

enum Direcao { ESQUERDA, DIREITA }
class OrigemVeiculos:
	var posicao_x: int
	var posicao_y: int
	var direcao: Direcao
	
	# This constructor lets you pass values when making it
	func _init(p_posx: int,p_posy: int, p_dir: Direcao) -> void:
		posicao_x = p_posx
		posicao_y = p_posy
		direcao = p_dir

var posicoes_onibus: Array[OrigemVeiculos] = [
	OrigemVeiculos.new(origem_carros_x_esquerda,604,Direcao.ESQUERDA),
	OrigemVeiculos.new(origem_carros_x_direita,117,Direcao.DIREITA)
]
var posicoes_bicletas: Array[OrigemVeiculos] = [
	OrigemVeiculos.new(origem_carros_x_esquerda,338,Direcao.ESQUERDA),
	OrigemVeiculos.new(origem_carros_x_direita,367,Direcao.DIREITA)
]
var velocidade_dos_lentos = 300
@onready var player:  = $Player
@onready var hud: CanvasLayer = $HUD
var pontos = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Mensagem.text =''
	$HUD/Button.hide()
	#if(player):
	#	player.pontua.connect(_on_pontua)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_pontua():
#	pontos = pontos +1
#	hud._on_pontua(pontos)


func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var aleatorio = randi_range(0,pistas_rapidas_y.size()-1)
	var posicao_pista_y = pistas_rapidas_y[aleatorio]
	carro.position = Vector2(origem_carros_x_esquerda,posicao_pista_y)
	carro.set_linear_velocity(Vector2(randf_range(velocidade_dos_rapidos,velocidade_dos_rapidos+10),0))
	carro.set_linear_damp(0.0)
	pass # Replace with function body.




func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var aleatorio = randi_range(0,pistas_lentas_y.size()-1)
	var posicao_pista_y = pistas_lentas_y[aleatorio]
	carro.position = Vector2(origem_carros_x_esquerda,posicao_pista_y)
	carro.set_linear_velocity(Vector2(randf_range(velocidade_dos_lentos,velocidade_dos_lentos+100),0))
	carro.set_linear_damp(0.0)
	pass # Replace with function body.


func _on_player_pontua() -> void:
	pontos = pontos +1
	hud._on_pontua(pontos)
	if(pontos==10):
		$HUD/Mensagem.text ='A Galinha nao foi triturada! Voce sobreviveu!'
		$HUD/Button.show()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$AudioTema.stop()
		$AudioVitoria.play()
		$Player.speed = 0
		pass
	
	pass # Replace with function body.


func _on_timer_onibus_timeout() -> void:
	var onibus = cena_onibus.instantiate()
	add_child(onibus)
	
	# 1. Get a random index
	var aleatorio = randi_range(0, posicoes_onibus.size() - 1)
	
	# 2. Extract the specific OrigemVeiculos element from the array
	var dados_origem: OrigemVeiculos = posicoes_onibus[aleatorio]
	
	
	var spawn_x = dados_origem.posicao_x
	var spawn_y = dados_origem.posicao_y
	
	# Set the position using the extracted data
	onibus.position = Vector2(spawn_x, spawn_y)
	
	# 4. Check the enum value to determine velocity direction
	
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Moving from left to right (Positive X velocity)
		onibus.set_linear_velocity(Vector2(velocidade_onibus, 0))
	elif dados_origem.direcao == Direcao.DIREITA:
		# Moving from right to left (Negative X velocity)
		onibus.set_linear_velocity(Vector2(-velocidade_onibus, 0))
		
		# Optional: Flip the sprite so the bus looks like it's driving left
		# assuming your bus scene has a Sprite2D or AnimatedSprite2D root
		if onibus.has_node("Sprite2D"): 
			onibus.get_node("Sprite2D").flip_h = true
			
	onibus.set_linear_damp(0.0)
	
	


func _on_timer_bicicleta_timeout() -> void:
	var bicicleta = cena_bicicleta.instantiate()
	add_child(bicicleta)
	
	# 1. Get a random index
	var aleatorio = randi_range(0, posicoes_bicletas.size() - 1)
	
	# 2. Extract the specific OrigemVeiculos element from the array
	var dados_origem: OrigemVeiculos = posicoes_bicletas[aleatorio]
	
	
	var spawn_x = dados_origem.posicao_x
	var spawn_y = dados_origem.posicao_y
	
	# Set the position using the extracted data
	bicicleta.position = Vector2(spawn_x, spawn_y)
	
	# 4. Check the enum value to determine velocity direction
	
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Moving from left to right (Positive X velocity)
		bicicleta.set_linear_velocity(Vector2(velocidade_bicicleta, 0))
	elif dados_origem.direcao == Direcao.DIREITA:
		# Moving from right to left (Negative X velocity)
		bicicleta.set_linear_velocity(Vector2(-velocidade_bicicleta, 0))
		
		# Optional: Flip the sprite so the bus looks like it's driving left
		# assuming your bus scene has a Sprite2D or AnimatedSprite2D root
		if bicicleta.has_node("Sprite2D"): 
			bicicleta.get_node("Sprite2D").flip_h = true
			
	bicicleta.set_linear_damp(0.0)
	
	


func _on_player_morreu() -> void:
	pontos = 0
	##hud._on_pontua(pontos)
	##if(pontos==10):
	$HUD/Mensagem.text ='GAME OVER ;-;'
	$HUD/Button.show()
	$TimerCarrosLentos.stop()
	$TimerCarrosRapidos.stop()
	$TimerOnibus.stop()
	$TimerBicicleta.stop()
	$AudioGameOver.play()
	
	$Player.speed = 0
		##pass
	
	pass # Replace with function body.
