extends Control

var property
var frame_per_second : String
var context

@onready var property_container = %VBoxContainer
@onready var panel = $Panel


func _ready() -> void:
	Global.debug_panel = self
	panel.visible = false
	context = $Context

func _process(delta: float) -> void:
	frame_per_second = str(Engine.get_frames_per_second())
	Global.debug_panel.add_property("FPS", frame_per_second, 0)
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_panel"):
		panel.visible = !panel.visible 
		context.visible = !context.visible

func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
