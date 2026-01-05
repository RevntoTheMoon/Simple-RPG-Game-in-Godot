extends CharacterBody3D


@export var speed := 5.0
@export var jump_velocity := 4.5

var mouse_sensivity: float = 0.01

@onready var head: Node3D = $Head

#@onready var camera = $MouseTrack/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		head.rotation.x -= event.relative.y * mouse_sensivity
		head.rotation.y -= event.relative.x * mouse_sensivity
		head.rotation.x = clamp(head.rotation.x, -1, 1)
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "foward", "backward").rotated(-head.global_rotation.y)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
