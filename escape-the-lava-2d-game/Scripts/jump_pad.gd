extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.y += -400
		$AnimationPlayer.play("jump")
		
	pass # Replace with function body.
