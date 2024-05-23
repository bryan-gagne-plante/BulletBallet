extends CharacterBody2D

@onready var player = get_node("/root/Game/CharacterBody2D")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()
