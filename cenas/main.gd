extends Node

@onready var player:  = $Player
@onready var hud: CanvasLayer = $HUD
var pontos = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if(player):
		player.pontua.connect(_on_pontua)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pontua():
	pontos = pontos +1
	hud._on_pontua(pontos)
