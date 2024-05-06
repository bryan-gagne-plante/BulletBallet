extends Area2D

const BULLET = preload("res://guns/pistol/bullet.tscn")
const SHOT_DELAY = 0.5

var time_since_shot = SHOT_DELAY

func _process(delta):
	# Manual aiming
	look_at(get_global_mouse_position())
	time_since_shot += delta
	if Input.is_action_pressed("shoot") && time_since_shot > SHOT_DELAY:
		shoot()
		time_since_shot = 0

# func _physics_process(delta):
	# Automatic aiming
	#var enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
	#	var target_enemy = enemies_in_range.front()
	#	look_at(target_enemy.global_position)

func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Barrel.global_position
	new_bullet.global_rotation = %Barrel.global_rotation
	%Barrel.add_child(new_bullet)

# Automatic shooting
#func _on_timer_timeout():
#	shoot()
