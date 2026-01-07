extends States
class_name Sprint

var acceleration: float = 0.05
var deceleration: float = 0.25
var speed: float = 7.0


func enter():
	pass

func update(): 
	entity.physics_update(speed, acceleration, deceleration)
	
	if not entity.is_on_floor():
		machine.change_state(machine.get_node("Airborne"))
	elif not Input.is_action_pressed("sprint"):
		machine.change_state(machine.get_node("Walk"))
	elif entity.velocity.length() == 0:
		machine.change_state(machine.get_node("Idle"))
	elif Input.is_action_pressed("dash"):
		machine.change_state(machine.get_node("Dash"))

func exit():
	machine.previous_speed = speed
