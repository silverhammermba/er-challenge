extends Control

const Data = preload("data.gd")

@onready var quad1: Quadrant = $CardArea/CardContainer/Card/Quadrant
@onready var quad2: Quadrant = $CardArea/CardContainer/Card/Quadrant2
@onready var quad3: Quadrant = $CardArea/CardContainer/Card/Quadrant3
@onready var quad4: Quadrant = $CardArea/CardContainer/Card/Quadrant4

var deck: Array[Data.Card] = []

func _ready() -> void:
	quad1.set_aspect(Data.Aspect.AWARENESS)
	quad2.set_aspect(Data.Aspect.SPIRIT)
	quad3.set_aspect(Data.Aspect.FITNESS)
	quad4.set_aspect(Data.Aspect.FOCUS)
	deck = Data.cards.duplicate()
	deck.shuffle()
	var card = deck.pop_back()


func update_card(card: Data.Card) -> void:
	quad1.set_number(card.awareness)
	quad2.set_number(card.spirit)
	quad3.set_number(card.fitness)
	quad4.set_number(card.focus)
	# TODO: effect
