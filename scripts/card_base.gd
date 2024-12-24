extends MarginContainer

# Choose a card name to display
var CardName = "Archer"

# Load the database to variable and then load that variable to another (active/in use) variable so that initial loaded variable isn't altered
@onready var CardDatabaseInit = preload("res://assets/cards/cardDatabase.gd")
@onready var CardDatabase = CardDatabaseInit.new()

# CardInfo(array) contains the value derivated from the dictionary, card information from card name from the card database
@onready var CardInfo = CardDatabase.cardData[CardDatabase.get(CardName)]


# First element of CardInfo array is the card name as string which is the same as the name of the card art
@onready var CardImg = str("res://assets/cards/card_art/",CardInfo[0],".png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(CardInfo)
	
	var CardSize = size #Size of the CardBase on the left, change this size and everything will scale to fit
	# Scaling the border size to the card base size, resets the scale to default(1) first
	$Border.scale = Vector2(1,1)
	$Border.scale *= CardSize / $Border.texture.get_size()
	
	# Scaling the card art to base card size, resets the scale to default(1) first
	$Card.texture = load(CardImg)
	$Card.scale = Vector2(1,1)
	$Card.scale *= CardSize / $Card.texture.get_size()
	
	#Pulls the card name to name label (as string to type fix)
	$Bars/TopBar/Name/CenterContainer/Name.text = str(CardInfo[0])
	
	#Pulls the card cost to cost label
	$Bars/TopBar/Cost/CenterContainer/Cost.text = str(CardInfo[1])
	
	#Pulls the keywords of the card to keywords label (might be multi line)
	$Bars/MidBar/Keywords/CenterContainer/Keywords.text = str(CardInfo[2])
	
	#Pulls the card stats to stats label
	$Bars/BottomBar/Stats/CenterContainer/Stats.text = str(CardInfo[3])
	
	#Pulls the card health to health label
	$Bars/BottomBar/Health/CenterContainer/Health.text = str(CardInfo[4])
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
