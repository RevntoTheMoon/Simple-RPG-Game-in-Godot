extends States
class_name CrouchState

var acceleration: float = 0.2
var deceleration: float = 0.25
var speed: float = 2.0


func enter():
	animation.play("crouch", -1, 6)

func update(): 
	entity.physics_update(speed, acceleration, deceleration)
	
	if not entity.is_on_floor():
		machine.change_state(machine.get_node("AirborneState"))
	elif not Input.is_action_pressed("crouch"):
		machine.change_state(machine.get_node("IdleState"))
		_uncrouch()

func exit():
	machine.previous_speed = speed
	
func _uncrouch():
	if %ShapeCast3D.is_colliding():
		await get_tree().create_timer(0.1).timeout
		_uncrouch()
	else:
		if animation:
			animation.play("crouch", -1, -6, true)
			if animation.is_playing():
				await animation.animation_finished
		machine.change_state(machine.get_node("IdleState"))
	
