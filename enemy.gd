extends CharacterBody2D
var direct:Vector2
var speed = 3
@onready var timer: Timer = $move
var screen
var colision
func _ready():
	screen = get_viewport().get_size()
	timer.start(randi_range(1, 2))
	direct = Vector2(randf_range(0.0, 1100.0), randf_range(0.0, 665.0)).normalized()
func _physics_process(delta: float) -> void:
	velocity = speed * direct
	colision = move_and_collide(velocity)
func _process(delta: float) -> void:
	if position.x < 0 or position.x > screen.x or position.y < 0 or position.y > screen.y:
		Global.clear.emit(self)
		pass
	if colision:
		print("COLLIDE")
		Global.collide.emit()
	
