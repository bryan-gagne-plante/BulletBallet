extends Area2D

var travelled_distance = 0;

func _physics_process(delta):
	const SPEED = 1000 
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	var distance = SPEED * delta
	position += direction * distance
	
	travelled_distance += distance
	if travelled_distance > RANGE:
		queue_free()
	


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
