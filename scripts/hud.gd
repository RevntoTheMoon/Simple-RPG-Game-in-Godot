extends Control

var text_health: Label

@onready var death_screen: Label = $DeathScreen

func _ready() -> void:
	text_health = $Health

func _physics_process(delta: float) -> void:
	text_health.text = "Health: " + str(Global.player.base_health) + " (RMB to heal & LMB to attack)"
	if Global.player.base_health == 0:
		death_screen.text = "You Died Lol"
