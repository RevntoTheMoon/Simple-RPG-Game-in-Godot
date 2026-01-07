extends States
class_name Crouch

var acceleration: float = 0.2
var deceleration: float = 0.25
var speed: float = 2.0


func enter():
	animation.play("crouch", -1, 6)

func update(): 
	entity.physics_update(speed, acceleration, deceleration)
	
	if not entity.is_on_floor():
		machine.change_state(machine.get_node("Airborne"))
	elif not Input.is_action_pressed("crouch"):
		machine.change_state(machine.get_node("Idle"))

func exit():
	animation.play("crouch", 0, -6, true)
	machine.previous_speed = speed
