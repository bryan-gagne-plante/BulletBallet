extends Area2D

const BULLET = preload("res://guns/pistol/bullet.tscn")
@export var shot_delay = 0.5
const SCALE = 0.373

var time_since_shot = shot_delay

func _process(delta):
	# Manual aiming and shooting
	look_at(get_global_mouse_position())
	rotate_weapon()
	
	time_since_shot += delta
	if Input.is_action_pressed("shoot") && time_since_shot > shot_delay:
		shoot()
		time_since_shot = 0

# func _physics_process(delta):
	# Automatic aiming
#	var enemies_in_range = get_overlapping_bodies()
#	if enemies_in_range.size() > 0:
#		var target_enemy = enemies_in_range.front()
#		look_at(target_enemy.global_position)
#		rotate_weapon()

func shoot():
	%Gunshot.play()
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Barrel.global_position
	new_bullet.global_rotation = %Barrel.global_rotation
	%Barrel.add_child(new_bullet)

# Automatic shooting
#func _on_timer_timeout():
#	shoot()

func rotate_weapon() :
	var rotation_modulo = int(abs(get_rotation_degrees())) % 360
	if (rotation_modulo <= 270 && rotation_modulo >= 90):
		%Pistol.scale = Vector2(SCALE, -SCALE)
	else:
		%Pistol.scale = Vector2(SCALE, SCALE)


func _on_player_hyper_survival_mode():
	shot_delay = 0.1
