extends Node

var kills: int = 0
var kills_needed: int = 20

@onready var slime_counter_label: Label=%SlimeCounterLabel

func enemy_killed():
	kills += 1
	print("Enemy Killed", kills, "/", kills_needed)
	
	if slime_counter_label:
		slime_counter_label.text = "Kills: %d/%d" % [kills, kills_needed]
		
	if kills >= kills_needed:
		end_game()
		
func end_game():
	get_tree().paused = true
	if slime_counter_label:
		slime_counter_label.text = "You Win! 20 slimes defeated!"
