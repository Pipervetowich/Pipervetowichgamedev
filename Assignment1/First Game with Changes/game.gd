extends Node2D

func music():
	%Backgroundmusic.volume_db = -10

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.show()
	%RestartBtn.show()


func _on_restart_btn_pressed() -> void:
	get_tree().paused = true
	get_tree().reload_current_scene()
