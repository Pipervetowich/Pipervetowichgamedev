extends CharacterBody2D

signal health_depleted

var health: float =100.0
var max_health: float = 100.0

@onready var gun2 = $Gun2
@onready var unlock_timer = $GunUnlockTimer
@onready var hp_bar = $HealthBar

func _physics_process(delta):
	const SPEED = 600.0
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	const DAMAGE_RATE = 6.0
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func _ready():
	gun2.visible = false 
	add_to_group("player")
	
func increase_health(amount: int):
	health = clamp(health + amount, 0,max_health)
	hp_bar.value = health
	

func _on_timer_timeout() -> void:
	gun2.visible = true
