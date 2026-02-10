extends CharacterBody3D
class_name Player

@export var animation: AnimationPlayer
@export var jump_velocity: float = 4.5

var mouse_sensivity: float = 0.01
var base_health: float = 100
var enemy = null

@onready var head: Node3D = $Head
@onready var ray_cast_3d: RayCast3D = $Head/RayCast3D

func _ready() -> void:
	Global.player = self
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		head.rotation.x -= event.relative.y * mouse_sensivity
		head.rotation.y -= event.relative.x * mouse_sensivity
		head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)
	if event.is_action_pressed("primary_action") and not enemy == null :
		enemy.base_health -= 20.0
	
	if event.is_action_pressed("secondary_action"):
		base_health += 20.0


func _physics_process(delta: float) -> void:
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider() is CharacterBody3D:
		enemy = ray_cast_3d.get_collider()
	else: 
		enemy = null
	
	#if %ShapeCast3D.is_colliding():
		#print("collide")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity


func physics_update(speed:float, acceleration: float, deceleration: float) -> void:
	var input_dir := Input.get_vector("left", "right", "foward", "backward").rotated(-head.global_rotation.y)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():	
		if direction:
			velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
			velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration)
			velocity.z = move_toward(velocity.z, 0, deceleration)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	Global.debug_panel.add_property("Velocity", snapped(velocity.length(), 0.01), 1)
	move_and_slide()
