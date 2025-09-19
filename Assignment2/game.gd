extends Node2D

@onready var kill_label: Label = %SlimeCounterLabel   # replace KillLabel with your actual label name


var kill_count: int = 0
const MAX_KILLS: int = 50

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.slime_died.connect(add_kill)
	add_child(new_mob)

func add_kill():
	kill_count += 1
	kill_label.text = "Kills: %d/%d" % [kill_count, MAX_KILLS]

	if kill_count >= MAX_KILLS:
		you_win()


func you_win():
	%YouWin.show()
	get_tree().paused = true


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.show()
	get_tree().paused = true
