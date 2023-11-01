extends RigidBody2D

#var dragging = false
#var click_radius = 20  # Size of the sprite.
#
#func _input(event):
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
#		var from = get_viewport().get_mouse_position()
#		if (event.position - global_position).length() < click_radius:
#			# Start dragging if the click is on the sprite.
#			if not dragging and event.pressed:
#				dragging = true
#
#		# Stop dragging if the button is released.
#		if dragging and not event.pressed:
#			dragging = false
#			var current_mouse_pos = get_global_mouse_position()
#			var velocity = (current_mouse_pos - from)  # Calculate velocity based on mouse movement.
#			self.apply_impulse(Vector2(), velocity)
#
#	if event is InputEventMouseMotion and dragging:
#		# While dragging, move the sprite with the mouse.
#		global_position = event.position  # Corrected line
#
@export var mouse_drag_scale = 20
var is_dragged = false

func _input_event(viewport, event, shape_idx):
	if _event_is_left_pressed(event): # check if left click is pressed on the body
		
		is_dragged = event.is_pressed()
		print(is_dragged)

func _input(event): # check if left click is released even outside of the body
	if _event_is_left_pressed(event) and not event.is_pressed():
		is_dragged = false
		print(is_dragged)

func _event_is_left_pressed(event):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT

func _integrate_forces(state):
	if is_dragged:
		state.linear_velocity = get_global_mouse_position() - global_position
		state.linear_velocity *= mouse_drag_scale

