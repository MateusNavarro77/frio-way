extends Area2D
#posicionar

@export var speed: float = 100.0 #100 pixels por segundo
var posicao_inicial: Vector2 = Vector2(640,690)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = posicao_inicial
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func somaDoida(a:float,b:float) -> float:
		return a+b
