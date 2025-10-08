extends CharacterBody2D

signal slime_died

var speed = randf_range(200, 300)
var health = 3

@onready var player = get_node("/root/Game/Player")

const HEALTH_POTION: PackedScene = preload("res://health_potion.tscn")

func _ready():
	%Slime.play_walk()


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()


func take_damage():
	%Slime.play_hurt()
	health -= 1

	if health == 0:
		var smoke_scene = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		drop_potion()
		emit_signal("slime_died")
		queue_free()

func drop_potion():
	var health_potion = HEALTH_POTION.instantiate()
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(0,10)
	print(random_number)
	if random_number == 1:
		
		get_parent().call_deferred("add_child", health_potion)
		
		health_potion.call_deferred("set", "global_position",global_position)
	
