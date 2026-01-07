extends States
class_name Walk

var acceleration: float = 0.2
var deceleration: float = 0.25
var speed: float = 5.0

func enter():
	pass

 
func update():
	entity.physics_update(speed, acceleration, deceleration)
	
	if not entity.is_on_floor():
		machine.change_state(machine.get_node("Airborne"))
	elif entity.velocity.length() == 0:
		machine.change_state(machine.get_node("Idle"))
	elif Input.is_action_pressed("sprint"):
		machine.change_state(machine.get_node("Sprint"))
	elif Input.is_action_pressed("crouch"):
		machine.change_state(machine.get_node("Crouch")) 
	elif Input.is_action_pressed("dash"):
		machine.change_state(machine.get_node("Dash"))

func exit():
	machine.previous_speed = speed
