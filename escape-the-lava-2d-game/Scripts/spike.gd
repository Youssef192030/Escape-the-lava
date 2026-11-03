extends CharacterBody2D

var falling = false

var gravity = 15
var has_spawned = false
func _physics_process(delta: float) -> void:
	
	if falling == true:
		velocity.y += gravity
		move_and_slide()
		
		if is_on_floor():
			velocity.y = 0
			if not has_spawned:
				particle()
				has_spawned = true
				$AnimationPlayer.play("alpha")
			await get_tree().create_timer(0.5).timeout
			queue_free()
	
	
func particle():
	var particle = preload("res://Scenes/fall.tscn")
	if is_on_floor():
		var part_ins = particle.instantiate()
		part_ins.emitting = true
		part_ins.global_position = global_position
		get_parent().add_child(part_ins)

func _on_killarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
		var dir = 1
		var knock_power = 300
		
		if position.x - body.position.x < 0:
			dir = 1
		elif position.x - body.position.x >= 0:
			dir = -1
		body.velocity = Vector2(dir * knock_power, -200)
		body.Damage()
	pass # Replace with function body.


func _on_fallarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		falling = true
	
	pass # Replace with function body.
