extends Node

export(PackedScene) var enemy_scene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	
	$HUD.show_game_over()
	$HUD/Music.play()
	$HUD/DeathSound.play()

func new_game():
	score = 0
	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$HUD/Music.play()



func _on_EnemyTimer_timeout():
	# Create a new instance of the Enemy scene
   var enemy = enemy_scene.instance()

   # Choose a random location on Path2D
   var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
   enemy_spawn_location.offset = randi()

   # Set the enemy's direction perpendicular to the path direction
   var direction = enemy_spawn_location.rotation + PI / 2
	
   # Set the enemy's position to a random location
   enemy.position = enemy_spawn_location.position
	
   # Add some randomness to the direction
   direction += rand_range(-PI / 4, PI / 4)
   enemy.rotation = direction
	
   # Choose the velocity for the enemy
   var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
   enemy.linear_velocity = velocity.rotated(direction)
	
   # Spawn the enemy by adding it to the Main scene
   add_child(enemy)



func _on_ScoreTimer_timeout():
	score += 1
	
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()

