
extends Node2D

@onready var label: Label = $HealthLabel

@export var lifetime: float = 1.0
@export var float_distance: float = 40.0

func setup(text: String, color: Color = Color.WHITE):
	label.text = text
	label.add_theme_color_override("font_color", color)

func _ready():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position:y", position.y - float_distance, lifetime)
	tween.tween_property(self, "modulate:a", 0.0, lifetime)
	tween.finished.connect(queue_free)
