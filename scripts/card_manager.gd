extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2
const DEFAULT_CARD_MOVE_SPEED = 0.1

# Card being dragged variable gets assigned the card node under the mouse
var node_under_mouse
var screen_size
var is_hovering_on_card
var player_hand_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_hand_reference = $"../PlayerHand"
	$"../InputManager".connect("left_mouse_button_released", on_left_click_released)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# "Drags" the node under the mouse
	if node_under_mouse:
		var mouse_pos = get_global_mouse_position()
		#Node.position gets changed to mouse position and clamped to screen size to prevent card leaving screen becoming inaccessible
		node_under_mouse.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y)) 

# Makes card bigger while dragged also point to card node in a particular way 
# 	triggering _process to start changing card position to cursor position resulting in "dragging"
func start_drag(card):
	node_under_mouse = card
	card.scale = Vector2(1.2, 1.2)

# Resolves stopping the dragging of a card
func finish_drag():
	var card_slot_found = raycast_check_for_card_slot()
	node_under_mouse.scale = Vector2(1.1, 1.1)
	# If Card dragged into an empty card slot do following
	if card_slot_found and card_slot_found.slot_empty:
		player_hand_reference.remove_card_from_hand(node_under_mouse)
		node_under_mouse.position = card_slot_found.position
		node_under_mouse.get_node("Area2D/CollisionShape2D").disabled = true
		card_slot_found.slot_empty = false
	else:
		player_hand_reference.add_card_to_hand(node_under_mouse, DEFAULT_CARD_MOVE_SPEED)
	
	node_under_mouse = null
	


# Recieves signals from its child card nodes
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

# Triggers stuff that happens when hovering over a card
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)

# Triggers/resolves everything that happens when mouse stops hovering a card
#	including the 'edge' case of draging a card over another card 
#	or having cards on top of each other
func on_hovered_off_card(card):
	if !node_under_mouse:
		highlight_card(card, false)
		# Check if hovered off one card straight on to another card
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered, true)
		else:
			is_hovering_on_card = false

# Drops the card on left click release
func on_left_click_released():
	if node_under_mouse:
		finish_drag()

# Makes the card under mouse bigger
func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(1.1, 1.1)
		card.z_index = 2
	else:
		card.scale = Vector2(1, 1)
		card.z_index = 1

#Raycasts
#Checks under the mouse, if there is a collision area returns the parent of the collision
func raycast_check_for_card():
	#Codefu
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		return get_card_with_highest_z_index(result)
	return null
	

# Raycast to detect card slots, used while dragging a card
func raycast_check_for_card_slot():
	#Codefu
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD_SLOT
	
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
		#return get_card_with_highest_z_index(result)
	return null
	

# Finding the card that is on top
func get_card_with_highest_z_index(cards):
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	# Loop through rest of the cards checking for a higher index
	for i in range(1, cards.size()):
		var current_card = cards[i].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
	return highest_z_card
