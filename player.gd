extends CharacterBody2D

@export var speed = 400  # pixels/sec
@export var health = 100.0 # health bar value
const DAMAGE_RATE = 5.0 # health dmg/sec
var last_direction = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("front_idle")

func _physics_process(delta):
	var moving_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moving_direction * speed

	if last_direction != moving_direction and moving_direction != Vector2.ZERO:
		last_direction = moving_direction

	animate_character(last_direction)
	move_and_slide()
	
	
func animate_character(direction):
	if Input.is_action_pressed("move_left"):
		flip_sprite_and_play_animation(true,"walk_right")
	elif Input.is_action_pressed("move_right"):
		flip_sprite_and_play_animation(false,"walk_right")
	elif Input.is_action_pressed("move_up"):
		$AnimationPlayer.play("walk_up")
	elif Input.is_action_pressed("move_down"):
		$AnimationPlayer.play("walk_down")
	else:
		play_idle_animation(direction)
		
func flip_sprite_and_play_animation(isFlipped, animation):
	$Sprite2D.flip_h = isFlipped
	$AnimationPlayer.play(animation)
			
func play_idle_animation(direction):
	if direction.y < 0:  # Moving up
		$AnimationPlayer.play("back_idle")
	elif direction.y > 0:  # Moving down
		$AnimationPlayer.play("front_idle")
	else:
		$AnimationPlayer.play("right_idle") # Sprite flipped in animate_character
	
func play_hurt():
	%AnimationPlayer.play("hit_up")
	%AnimationPlayer.queue("walk_down")
