extends Node2D


func play_walk():
	%AnimationPlayer.play("walk")

	%Slimewalk.play()

func play_hurt():
	%AnimationPlayer.play("hurt")
	
	%Slimedeath.play()
