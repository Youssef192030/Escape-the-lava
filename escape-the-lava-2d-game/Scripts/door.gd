extends Area2D
@onready var invicible_wall = $StaticBody2D/CollisionShape2D



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("keys"):
		invicible_wall.queue_free()
		area.queue_free()
		$Sprite2D.scale.x = 1
		$"../Label".text = "Opened"
	pass # Replace with function body.
