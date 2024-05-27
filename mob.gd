extends CharacterBody2D

const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")

@export var health = 3
@onready var player = get_node("/root/Game/Player")


func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
