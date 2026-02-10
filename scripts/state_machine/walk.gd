extends States
class_name WalkState

var acceleration: float = 0.2
var deceleration: float = 0.25
var speed: float = 5.0

func enter():
	pass

 
func update():
	entity.physics_update(speed, acceleration, deceleration)
	
	if not entity.is_on_floor():
		machine.change_state(machine.get_node("AirborneState"))
	elif entity.velocity.length() == 0:
		machine.change_state(machine.get_node("IdleState"))
	elif Input.is_action_pressed("sprint"):
		machine.change_state(machine.get_node("SprintState"))
	elif Input.is_action_pressed("crouch"):
		machine.change_state(machine.get_node("CrouchState")) 
	elif Input.is_action_pressed("dash"):
		machine.change_state(machine.get_node("DashState"))

func exit():
	machine.previous_speed = speed
