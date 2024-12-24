extends MarginContainer

signal hovered
signal hovered_off

var card_position_in_hand

# Load the database to variable and then load that variable to another (active/in use) variable so that initial loaded variable isn't altered
@onready var CardDatabaseInit = preload("res://assets/cards/cardDatabase.gd")
@onready var CardDatabase = CardDatabaseInit.new()

# CardInfo(array) contains the value derivated from the dictionary, card information from card name from the card database
var CardName = "Strike"
@onready var CardInfo = CardDatabase.cardData[CardDatabase.get(CardName)]


# First element of CardInfo array is the card name as string which is the same as the name of the card art
#@onready var CardImg = str("res://assets/cards/card_art/",CardInfo[0],".png")
@onready var CardImg = str("res://assets/StS Card assets/Silent Strike Art.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(CardInfo)
	# Scaling the border size to the card base size. Scrapped to instead scaling to half size in node
	#var CardSize = size
	#$Background.scale *= CardSize / $Background.texture.get_size()
	#print($Background.scale)
	# Scaling the card art to fit. Scrapped to instead scaling to half size in node
	$Card.texture = load(CardImg)
#	$Card.scale *=  Vector2(512, 424) / $Card.texture.get_size() * 0.5
#	print($Card.scale)
#	$Bars/Banner.scale *= Vector2(512, 424) / $Card.texture.get_size() * 0.5
#	print($Bars/Banner.scale)
	
	
	#print($".".pivot_offset.x)
	$".".pivot_offset.x = int($Background.texture.get_size().x * .5)
	$".".pivot_offset.y = int($Background.texture.get_size().y * .5)
	
	# All cards must be a child of CardManager or this will error, 
	#	if card scene is run instead of main scene this will again error and 
	#	until you run the code without this section it willl continue to error even if you run main
	$"..".connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)
