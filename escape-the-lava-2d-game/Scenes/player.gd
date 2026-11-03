extends CharacterBody2D

var speed = 150
var slide_speed = 250
var jump_power = 250
var gravity = 15
var moving = false
var now_running = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	velocity.y += gravity
	moving = false
	$CPUParticles2D.emitting = false
	
	Move()
	Run()
	Stamina()
	Stamina_regen()
	Jump()
	animations()
	
	
	
	
	
	
	move_and_slide()

	
func Move():
	if Input.is_action_pressed("right"):
		velocity.x = lerpf(velocity.x, speed, 0.1)
		moving = true
		animated_sprite_2d.scale.x = 1
		$CPUParticles2D.emitting = true
	elif Input.is_action_pressed("left"):
		velocity.x = lerpf(velocity.x, -speed, 0.1)
		moving = true
		animated_sprite_2d.scale.x = -1
		$CPUParticles2D.emitting = true
	else:
		velocity.x = lerpf(velocity.x, 0, 0.2)
		
func Run():
	if Input.is_action_pressed("run"):
		speed = 200
		animated_sprite_2d.speed_scale = 2
		now_running = true
	else:
		speed = 150
		animated_sprite_2d.speed_scale = 1
		now_running = false
		
func Jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y += -jump_power
			
func Damage():
	get_node("Control/Player_UI/Health").value -= 1
	if get_node("Control/Player_UI/Health").value == 0:
		get_tree().reload_current_scene()

func Stamina():
	if Input.is_action_pressed("run") and moving == true:
		get_node("Control/Player_UI/stamina").value -= 0.4
		if get_node("Control/Player_UI/stamina").value == 0:
			animated_sprite_2d.speed_scale = 1
			speed = 150
			
func Stamina_regen():
	if get_node("Control/Player_UI/stamina").value == 0:
		await get_tree().create_timer(1).timeout
		get_node("Control/Player_UI/stamina").value += 2
	if Input.is_action_just_released("run"):
		await get_tree().create_timer(1).timeout
		get_node("Control/Player_UI/stamina").value += 100 - get_node("Control/Player_UI/stamina").value
		
func animations():
	if moving == false:
		animated_sprite_2d.play("idle")
	if moving == true:
		animated_sprite_2d.play("run")
	if not is_on_floor():
		animated_sprite_2d.play("jump")
		$CPUParticles2D.emitting = false
	
