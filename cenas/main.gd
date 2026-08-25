extends Node


var cena_carros = preload("res://cenas/carros.tscn")
var pistas_rapidas_y = [104,272,488]
var pistas_lentas_y = [160,216,324,384,438,544,600]
var origem_carros_x = -10
var velocidade_dos_rapidos = 700

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
	carro.position = Vector2(origem_carros_x,posicao_pista_y)
	carro.set_linear_velocity(Vector2(randf_range(velocidade_dos_rapidos,velocidade_dos_rapidos+10),0))
	carro.set_linear_damp(0.0)
	pass # Replace with function body.




func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var aleatorio = randi_range(0,pistas_lentas_y.size()-1)
	var posicao_pista_y = pistas_lentas_y[aleatorio]
	carro.position = Vector2(origem_carros_x,posicao_pista_y)
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
