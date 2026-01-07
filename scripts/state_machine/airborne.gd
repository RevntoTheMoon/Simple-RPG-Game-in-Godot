extends States
class_name Airborne

var acceleration: float = 0.007
var deceleration: float = 0.25
var speed: float

func enter():
	speed = machine.previous_speed

func update(): 
	entity.physics_update(speed, acceleration, deceleration)
	
	if entity.is_on_floor():
		if entity.velocity.length() > 0:
			machine.change_state(machine.get_node("Walk"))
		else:
			machine.change_state(machine.get_node("Idle"))
	elif Input.is_action_pressed("dash"):
		machine.change_state(machine.get_node("Dash"))
func exit():
	pass
