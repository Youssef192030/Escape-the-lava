extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.get_node("Control/Player_UI/Health").value += 1
		queue_free()
