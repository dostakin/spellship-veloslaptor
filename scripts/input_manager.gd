extends Node2D

signal left_mouse_button_clicked
signal left_mouse_button_released

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2
# Collision mask value 3 corresponds to integer 4
const COLLISION_MASK_DECK = 4

var card_manager_reference
var deck_reference

func _ready() -> void:
	card_manager_reference = $"../CardManager"
	deck_reference = $"../Deck"

func _input(event):
	# takes input of left mouse button press and release.
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# When mouse left button is pressed runs the function, function looks for a node, 
		#	if found, node is loaded to the variable and sent to _process
		if event.pressed:
			emit_signal("left_mouse_button_clicked")
			raycast_at_cursor()
		# Variable is reset when button is released
		else:
			emit_signal("left_mouse_button_released")

#Checks under the mouse, if there is a collision area returns the parent of the collision
func raycast_at_cursor():
	#Codefu
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_collision_mask = result[0].collider.collision_mask
		# Card under cursor when clicked
		if result_collision_mask == COLLISION_MASK_CARD:
			var card_found = result[0].collider.get_parent()
			if card_found:
				card_manager_reference.start_drag(card_found)
		# Deck under cursor when clicked
		elif result_collision_mask == COLLISION_MASK_DECK:
			deck_reference.draw_card()
