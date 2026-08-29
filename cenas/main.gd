extends Node

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
# ==========================================
# CENAS
# ==========================================

var cena_carros = preload("res://cenas/carros.tscn")
var cena_onibus = preload("res://cenas/onibus.tscn")
var cena_bicicleta = preload("res://cenas/bicicleta.tscn")


# ==========================================
# POSIÇÕES DE NASCIMENTO
# ==========================================

var origem_carros_x_esquerda = -10
var origem_carros_x_direita = 1290


# ==========================================
# VELOCIDADES
# ==========================================

var velocidade_dos_rapidos = 450
var velocidade_dos_lentos = 200
var velocidade_onibus = 300.0
var velocidade_bicicleta = 150


# ==========================================
# DIREÇÃO
# ==========================================
#
# ESQUERDA:
#   nasce na DIREITA
#   vai para a ESQUERDA
#
# DIREITA:
#   nasce na ESQUERDA
#   vai para a DIREITA
#

enum Direcao {
	ESQUERDA,
	DIREITA
}


# ==========================================
# ORIGEM DOS VEÍCULOS
# ==========================================

class OrigemVeiculos:
	var posicao_x: int
	var posicao_y: int
	var direcao: Direcao
	
	func _init(p_posx: int, p_posy: int, p_dir: Direcao) -> void:
		posicao_x = p_posx
		posicao_y = p_posy
		direcao = p_dir


# ==========================================
# POSIÇÕES DOS CARROS RÁPIDOS
# ==========================================

var posicoes_carros_rapidos: Array[OrigemVeiculos] = [
	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_direita, 183, Direcao.ESQUERDA),

	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_direita, 287, Direcao.ESQUERDA),

	# Nasce na direita e vai para a esquerda
	OrigemVeiculos.new(origem_carros_x_esquerda, 480, Direcao.DIREITA)
]


# ==========================================
# POSIÇÕES DOS CARROS LENTOS
# ==========================================

var posicoes_carros_lentos: Array[OrigemVeiculos] = [
	# Nasce na direita e vai para a esquerda
	OrigemVeiculos.new(origem_carros_x_direita, 240, Direcao.ESQUERDA),

	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_esquerda, 423, Direcao.DIREITA),

	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_esquerda, 540, Direcao.DIREITA)
]


# ==========================================
# POSIÇÕES DOS ÔNIBUS
# ==========================================

var posicoes_onibus: Array[OrigemVeiculos] = [
	# Nasce na direita e vai para a esquerda
	OrigemVeiculos.new(origem_carros_x_esquerda, 604, Direcao.DIREITA),

	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_direita, 117, Direcao.ESQUERDA)
]


# ==========================================
# POSIÇÕES DAS BICICLETAS
# ==========================================

var posicoes_bicletas: Array[OrigemVeiculos] = [
	# Nasce na direita e vai para a esquerda
	OrigemVeiculos.new(origem_carros_x_direita, 338, Direcao.ESQUERDA),

	# Nasce na esquerda e vai para a direita
	OrigemVeiculos.new(origem_carros_x_esquerda, 367, Direcao.DIREITA)
]


# ==========================================
# PLAYER / HUD
# ==========================================

@onready var player = $Player
@onready var hud: CanvasLayer = $HUD

var pontos = 0
const pontos_para_ganhar = 3
const tempo_game_over = 60 # 300 segundos
var tempo_restante = tempo_game_over

# ==========================================
# READY
# ==========================================

func _ready() -> void:
	$HUD/Mensagem.text = ""
	hud._atualizar_tempo_restante(tempo_restante)
	$HUD/Button.hide()


# ==========================================
# PROCESS
# ==========================================

func _process(delta: float) -> void:
	pass


# ==========================================
# CARROS RÁPIDOS
# ==========================================

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)

	# Escolhe uma origem aleatória
	var aleatorio = randi_range(0, posicoes_carros_rapidos.size() - 1)
	var dados_origem: OrigemVeiculos = posicoes_carros_rapidos[aleatorio]

	# Define posição de nascimento
	carro.position = Vector2(
		dados_origem.posicao_x,
		dados_origem.posicao_y
	)

	# Define direção
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Nasceu na direita -> vai para a esquerda
		carro.set_linear_velocity(
			Vector2(
				-randf_range(
					velocidade_dos_rapidos,
					velocidade_dos_rapidos + 10
				),
				0
			)
		)

		if carro.has_node("Sprite2D"):
			carro.get_node("Sprite2D").flip_h = true

	elif dados_origem.direcao == Direcao.DIREITA:
		# Nasceu na esquerda -> vai para a direita
		carro.set_linear_velocity(
			Vector2(
				randf_range(
					velocidade_dos_rapidos,
					velocidade_dos_rapidos + 10
				),
				0
			)
		)

	carro.set_linear_damp(0.0)


# ==========================================
# CARROS LENTOS
# ==========================================

func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)

	# Escolhe uma origem aleatória
	var aleatorio = randi_range(0, posicoes_carros_lentos.size() - 1)
	var dados_origem: OrigemVeiculos = posicoes_carros_lentos[aleatorio]

	# Define posição de nascimento
	carro.position = Vector2(
		dados_origem.posicao_x,
		dados_origem.posicao_y
	)

	# Define direção
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Nasceu na direita -> vai para a esquerda
		carro.set_linear_velocity(
			Vector2(
				-randf_range(
					velocidade_dos_lentos,
					velocidade_dos_lentos + 100
				),
				0
			)
		)

		if carro.has_node("Sprite2D"):
			carro.get_node("Sprite2D").flip_h = true

	elif dados_origem.direcao == Direcao.DIREITA:
		# Nasceu na esquerda -> vai para a direita
		carro.set_linear_velocity(
			Vector2(
				randf_range(
					velocidade_dos_lentos,
					velocidade_dos_lentos + 100
				),
				0
			)
		)

	carro.set_linear_damp(0.0)


# ==========================================
# PONTUAÇÃO
# ==========================================

func _on_player_pontua() -> void:
	pontos = pontos + 1
	hud._on_pontua(pontos)

	if pontos == pontos_para_ganhar:
		$HUD/Mensagem.text = "Sobreviveu!"
		$HUD/Button.show()

		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$TimerOnibus.stop()
		$TimerBicicleta.stop()
		$TimerGameOver.stop()
		$AudioTema.stop()
		$AudioVitoria.play()

		$Player.speed = 0


# ==========================================
# ÔNIBUS
# ==========================================

func _on_timer_onibus_timeout() -> void:
	var onibus = cena_onibus.instantiate()
	add_child(onibus)

	# Escolhe uma origem aleatória
	var aleatorio = randi_range(0, posicoes_onibus.size() - 1)
	var dados_origem: OrigemVeiculos = posicoes_onibus[aleatorio]

	# Define posição
	onibus.position = Vector2(
		dados_origem.posicao_x,
		dados_origem.posicao_y
	)

	# Define direção
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Nasceu na direita -> vai para a esquerda
		onibus.set_linear_velocity(
			Vector2(-velocidade_onibus, 0)
		)

		if onibus.has_node("Sprite2D"):
			onibus.get_node("Sprite2D").flip_h = true

	elif dados_origem.direcao == Direcao.DIREITA:
		# Nasceu na esquerda -> vai para a direita
		onibus.set_linear_velocity(
			Vector2(velocidade_onibus, 0)
		)

	onibus.set_linear_damp(0.0)


# ==========================================
# BICICLETAS
# ==========================================

func _on_timer_bicicleta_timeout() -> void:
	var bicicleta = cena_bicicleta.instantiate()
	add_child(bicicleta)

	# Escolhe uma origem aleatória
	var aleatorio = randi_range(0, posicoes_bicletas.size() - 1)
	var dados_origem: OrigemVeiculos = posicoes_bicletas[aleatorio]

	# Define posição
	bicicleta.position = Vector2(
		dados_origem.posicao_x,
		dados_origem.posicao_y
	)

	# Define direção
	if dados_origem.direcao == Direcao.ESQUERDA:
		# Nasceu na direita -> vai para a esquerda
		bicicleta.set_linear_velocity(
			Vector2(-velocidade_bicicleta, 0)
		)

		if bicicleta.has_node("Sprite2D"):
			bicicleta.get_node("Sprite2D").flip_h = true

	elif dados_origem.direcao == Direcao.DIREITA:
		# Nasceu na esquerda -> vai para a direita
		bicicleta.set_linear_velocity(
			Vector2(velocidade_bicicleta, 0)
		)

	bicicleta.set_linear_damp(0.0)


# ==========================================
# PLAYER MORREU
# ==========================================

func _on_player_morreu() -> void:
	perder_jogo()


func _on_timer_game_over_timeout() -> void:
	tempo_restante = tempo_restante -1
	hud._atualizar_tempo_restante(tempo_restante)
	if(tempo_restante==0):
		perder_jogo()
	pass # Replace with function body.


func perder_jogo():
	pontos = 0
	tempo_restante = tempo_game_over

	$HUD/Mensagem.text = "GAME OVER ;-;"
	$HUD/Button.show()

	$TimerCarrosLentos.stop()
	$TimerCarrosRapidos.stop()
	$TimerOnibus.stop()
	$TimerBicicleta.stop()
	$TimerGameOver.stop()

	$AudioGameOver.play()

	$Player.speed = 0
	
