extends CharacterBody2D

signal health_depleted

var health: float =100.0
var max_health: float = 100.0

@onready var gun2 = $Gun2
@onready var unlock_timer = $GunUnlockTimer
@onready var hp_bar = $HealthBar

const FLOATING_TEXT = preload("res://healthtext.tscn")


func _physics_process(delta):
	const SPEED = 600.0
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	move_and_slide()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.animation = "default"
		#everything else is for when moving
		
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "right"
		%Grasssteps.play()
		
	if velocity.x < 0:
		$AnimatedSprite2D.animation = "left"
		%Grasssteps.play()
		
	if velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
		%Grasssteps.play()
		
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		%Grasssteps.play()
		
	
	const DAMAGE_RATE = 6.0
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%Hit.play()
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func _ready():
	gun2.visible = false 
	add_to_group("player")
	
func increase_health(amount: int):
	health = clamp(health + amount, 0,max_health)
	hp_bar.value = health
	show_floating_text("+%d" % amount, Color.GREEN)

func _on_timer_timeout() -> void:
	gun2.visible = true
	%Gun_2.show()

func show_floating_text(text: String, color: Color):
	var scene := preload("res://healthtext.tscn")
	var popup = scene.instantiate()
	popup.setup(text, color)

	# place popup slightly above the player’s head
	popup.position = global_position + Vector2(0, -20)

	# add to the same parent as the player so it stays in world space
	get_parent().add_child(popup)
