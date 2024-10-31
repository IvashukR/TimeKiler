extends Node2D
var start_pos:Vector2 = Vector2.ZERO
var end_pos:Vector2 = Vector2.ZERO
var widht_lin:float = 2.0
var color:Color = Color(1, 0, 0)
var drawing: bool = false
var count:int = 0
var isReady: bool = false
var e
var isActive
var colision
var counter = 0
@onready var spawner_1: Node2D = $Spawn/spawner1
@onready var spawner_2: Node2D = $Spawn/spawner2
@onready var spawner_3: Node2D = $Spawn/spawner3
@onready var character_body_2d: CharacterBody2D = $player
@onready var spawn_timer: Timer = $spawnTimer
@onready var gradient: TextureRect = $Spawn/Control/Gradient
@onready var restart: Button = $Spawn/Control/restart


var enim = load("res://enemy.tscn")
func collide():
	gradient.visible = true
	restart.visible = true
	$Spawn/Control.visible = true
	
func clear(obj):
	obj.queue_free()
func _ready():
	Global.clear.connect(clear)
	Global.collide.connect(collide)
	get_tree().paused = true
	spawn_timer.start(randi() % 5)
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			count += 1
			start_pos = event.position
			drawing = true
	
		else:
			end_pos = event.position
			drawing = false
			queue_redraw()
	elif event is InputEventMouseMotion && drawing:
		end_pos = event.position
		queue_redraw()
			
			
			
	pass
func _draw() -> void:
	if drawing || start_pos != end_pos:
		draw_line(start_pos, end_pos, color, widht_lin)
	pass
func _process(delta: float) -> void:
	if end_pos == Vector2.ZERO:
		isActive = false
	else:
		isActive == true
	if colision:
		print("COLIDE")
	$Spawn/Control/counter.text = "WIN :" + str(counter)
	pass
func _physics_process(delta: float) -> void:
	if character_body_2d.global_position != end_pos :
		character_body_2d.global_position = lerp(character_body_2d.global_position, end_pos, 0.01)
	character_body_2d.move_and_slide()
	#var colision = $CharacterBody2D.move_and_collide($CharacterBody2D.global_position)


func _on_timer_timeout() -> void:
	print("timeout1")
	get_tree().paused = false
	pass 



func _on_spawn_timer_timeout() -> void:
	var spawner = [spawner_1.global_position, spawner_2.global_position, spawner_3.global_position]
	for i  in randf_range(3, 10):
		e = enim.instantiate()
		e.global_position = spawner[randi_range(0, 2)]
		add_child(e)
	spawn_timer.start(randi() % 5)
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://drawline.tscn")
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		collide()
	$Spawn/Control/Label.visible = true
	$Spawn/Control/counter.visible = true
	print("ENTER")
	counter += 1
	
	pass # Replace with function body.
