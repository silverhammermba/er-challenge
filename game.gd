extends Control

const Data = preload("data.gd")

@onready var card: Control = $CardArea/CardContainer/Card
@onready var quad1: Quadrant = $CardArea/CardContainer/Card/Quadrant
@onready var quad2: Quadrant = $CardArea/CardContainer/Card/Quadrant2
@onready var quad3: Quadrant = $CardArea/CardContainer/Card/Quadrant3
@onready var quad4: Quadrant = $CardArea/CardContainer/Card/Quadrant4
@onready var effect: ColorRect = $CardArea/CardContainer/Card/Effect
@onready var effect_icon: TextureRect = $CardArea/CardContainer/Card/Effect/Icon
@onready var effect_shuffle: TextureRect = $CardArea/CardContainer/Card/Effect/Shuffle

var deck: Array[Data.Card] = []

func _ready() -> void:
	quad1.set_aspect(Data.Aspect.AWARENESS)
	quad2.set_aspect(Data.Aspect.SPIRIT)
	quad3.set_aspect(Data.Aspect.FITNESS)
	quad4.set_aspect(Data.Aspect.FOCUS)
	reshuffle()

func update_card(new_card: Data.Card) -> void:
	quad1.set_number(new_card.awareness)
	quad2.set_number(new_card.spirit)
	quad3.set_number(new_card.fitness)
	quad4.set_number(new_card.focus)
	effect.color = Data.effect_color(new_card.effect)
	# TODO: effect icon
	effect_shuffle.visible = new_card.need_shuffle()

func shuffle() -> void:
	deck = Data.cards.duplicate()
	deck.shuffle()
	
func reshuffle() -> void:
	shuffle()
	card.visible = false

func draw() -> void:
	var new_card: Data.Card = deck.pop_back()
	update_card(new_card)
	if new_card.need_shuffle():
		shuffle()
	card.visible = true

func _on_reshuffle_pressed() -> void:
	reshuffle()

func _on_draw_pressed() -> void:
	draw()
