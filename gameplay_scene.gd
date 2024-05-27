extends Node2D

@export var number_of_trees = 50
var tree = preload("res://tree.tscn")
var tree_positions = PackedVector2Array()

@export var grid_width = 4000
@export var grid_height = 4000

@export var min_distance_between_trees = 250

var player

var generated_grids = []

func _ready():
	player = get_node("Player")
	generate_grid(Vector2(0, 0))

func _process(_delta):
	if player:
		var player_position = player.global_position
		var current_grid = Vector2(floor(player_position.x / grid_width), floor(player_position.y / grid_height))
		for offset in [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]:
			var grid_to_check = current_grid + offset
			if not is_grid_generated(grid_to_check):
				generate_grid(grid_to_check)

func generate_grid(grid_position):
	generated_grids.append(grid_position)
	var base_position = Vector2(grid_position.x * grid_width, grid_position.y * grid_height)
	
	for i in range(number_of_trees):
		var valid_position = false
		var random_position = Vector2()
		
		while not valid_position:
			random_position = Vector2(randf() * grid_width, randf() * grid_height) + base_position
			if is_position_valid(random_position):
				valid_position = true

		spawn_tree(random_position)

func spawn_tree(pos):
	var instance = tree.instantiate()
	instance.position = pos
	add_child(instance)
	tree_positions.append(pos)

func is_position_valid(pos):
	for i in range(tree_positions.size()):
		if pos.distance_to(tree_positions[i]) < min_distance_between_trees:
			return false
	return true

func is_grid_generated(grid_position):
	return grid_position in generated_grids

func _init():
	randomize()

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
	%GameOver/ColorRect/GameOverSound.play()
