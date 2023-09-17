extends Node

@export var mob_scene: PackedScene
var score


func _ready():
#	new_game()
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("teio", "queue_free")
	$Music.play()
	
func _on_score_timer_timeout():
	score +=1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_mob_timer_timeout():
	#tao instance cua Mob
	var mob = mob_scene.instantiate()
	
	#Chon vi tri bat ki o Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	#sol1
	#set huong cua mob thanh huong duong di
#	var direction = mob_spawn_location.rotation + PI/2
#	direction = randf_range(-PI/4, PI/4)
	#sol2
	var direction = mob.position.direction_to($Player.position).angle()
	direction += randf_range(-PI/4,PI/4)
	print(direction)
	
	#set vi tri cho mob
	
	
	#random huong di cua mob
	mob.rotation = direction
	
	#Set gia toc
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	
	
	
	
	
	
	
	
	
