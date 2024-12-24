extends Node

# This will be a database for all cards
# Card names will be declared as constants in enum, they will be the keys of the dictionary
# Cards will be stored as a dictionary with their names as key and all their data as value as an array

# Format:: CardName a unique string and key, name of the card, declared as a constant in enum
# Elements in the array each represent a value of the card combined they describe the entire card
# Card Name: is name of the card as shown to the player, usually same as the the key
# Card Type: think attack, skill, power, curse from Slay the Spire, WIP
# Card Target: Enemy, self, ally(not including self?), all, all enemy, all allies
# Card Class: Jammer, Gunner etc. used to bundle/filter the cards  
# Key Words: An array of strings, key words, mentioned in the card so that they can be explained in an extra text bubble
# Upgradable: boolean, upgradability of the card
# Upgrades To: The name of the card this card upgrades to
# Card Text: The text of the card
# CardName : [CardName: Str, CardType: Str, CardTarget: Str, CardClass: Str, Keywords: Array, 
#		Upgradable: bool, UpgradesTo: Str, CardText: Str]

# Declares card names (keys) as constants so that other scripts that call this can use these 
# 	constant names to summon card info
enum {Bash, BashUp, Archer, Footman, Strike}

# Data of all cards
const cardData = {
	Bash: ["Bash", "Attack", "Enemy", "Ironclad", ["Vulnerable"], true, "BashUp", "Deal 8 damage.\n Apply 2 Vulnerable."],
	BashUp: ["Bash+", "Attack", "Enemy", "Ironclad", ["Vulnerable"], false, "", "Deal 10 damage.\n Apply 3 Vulnerable."],
	#Archer : [name, cost, keywords, stats, health]
	Archer: ["Archer", 2, "Ranged \n First Strike", "2/1", 3],
	Footman: ["Footman", 1, "Melee", "1/1", 2],
	Strike: ["Strike"],
	
	}


# For testing the database
func _ready() -> void:
	#print(Bash)
	pass
