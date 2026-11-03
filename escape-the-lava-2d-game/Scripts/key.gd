extends Area2D

var dir = global_scale

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var dir = 1
		var marker = body.get_node("AnimatedSprite2D/Marker2D")
		$AnimationPlayer.stop()
		$CPUParticles2D.emitting = false
		reparent(marker)
		
		position = Vector2(2,0)
		if position.x - body.position.x < 0:
			dir = -1
		elif position.x - body.position.x >= 0:
			dir = 1
		scale.x = dir
		
		if Input.is_action_pressed("right"):
			scale.x = 1
		
		if Input.is_action_pressed("left"):
			scale.x = -1
	
	pass # Replace with function body.
