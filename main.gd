extends Node

@export var mod_scene: PackedScene
var score

func game_over():
	$ScoreTimer.stop()
	$ModTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeadSound.play()

func game_start():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mod_timer_timeout():
	# Create a new instance of the Mob scene.
	var mod = mod_scene.instantiate()
	
	# Choose a random location on Path2D.
	var mod_spawn_location = get_node("ModPath/ModSpawnLocation")
	mod_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mod_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	mod.position = mod_spawn_location.position
	
	# Add some randomness to the direction.
	direction += randf_range(deg_to_rad(90), deg_to_rad(180))
	mod.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mod.linear_velocity = velocity.rotated(direction)
	
	add_child(mod)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$ModTimer.start()
	$ScoreTimer.start()


func new_game():
	game_start()
	$Music.play()
	$HUD.update_score(score)
	$HUD.show_message("Ready")
	get_tree().call_group("mods", "queue_free")
	
