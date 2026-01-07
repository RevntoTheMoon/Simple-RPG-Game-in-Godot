extends States
class_name Idle

var acceleration: float = 0.2
var deceleration: float = 0.25
var speed: float = 5.0

func enter():
	entity.velocity = Vector3.ZERO

func update():
	entity.physics_update(speed, acceleration, deceleration)
	
	if entity.velocity.length() > 0.0:
		machine.change_state(machine.get_node("Walk"))
	elif Input.is_action_pressed("crouch"):
		machine.change_state(machine.get_node("Crouch"))
	elif Input.is_action_pressed("dash"):
		machine.change_state(machine.get_node("Dash"))
	
func exit():
	previous_speed = speed
