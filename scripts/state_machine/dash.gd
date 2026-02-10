extends States
class_name DashState

var speed := 20.0
var duration := 0.2
var timer := 0.0

var acceleration: float = 0.2
var deceleration: float = 0.25

func enter():
	timer = duration


func _process(delta: float) -> void: 
	timer -= delta

func update():
	entity.physics_update(speed, acceleration, deceleration)
	if timer <= 0:
		if entity.is_on_floor():
			machine.change_state(machine.get_node("IdleState"))
		else:
			machine.change_state(machine.get_node("AirborneState"))
