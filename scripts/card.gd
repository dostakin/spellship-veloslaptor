extends Node2D

signal hovered
signal hovered_off

var card_position_in_hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# All cards must be a child of CardManager or this will error, 
	#	if card scene is run instead of main scene this will again error and 
	#	until you run the code without this section it willl continue to error even if you run main
	$"..".connect_card_signals(self)
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)



func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)
