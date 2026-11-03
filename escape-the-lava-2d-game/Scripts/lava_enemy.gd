extends CharacterBody2D

var gravity = 8
var speed = 350
var jump = false
	
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity
	if is_on_floor():
		Enemy_Jump()
		
		
	move_and_slide()
	if velocity.y > gravity:
		$Sprite2D.flip_v = true
	else:
		$Sprite2D.flip_v = false

func Enemy_Jump():
	velocity.y += -speed


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var dir = 1
		var knock_power = 100
		
		if position.x - body.position.x < 0:
			dir = -1
		elif position.x - body.position.x >= 0:
			dir = 1
		body.velocity = Vector2(dir * knock_power, -100)
		body.moving = false
		body.Damage()
	pass # Replace with function body.
