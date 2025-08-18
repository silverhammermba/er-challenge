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
@onready var bar_awa: Bars = $BarArea/Bars/Awareness
@onready var bar_spi: Bars = $BarArea/Bars/Spirit
@onready var bar_fit: Bars = $BarArea/Bars/Fitness
@onready var bar_foc: Bars = $BarArea/Bars/Focus

var deck: Array[Data.Card] = []

func _ready() -> void:
	quad1.set_aspect(Data.Aspect.AWARENESS)
	quad2.set_aspect(Data.Aspect.SPIRIT)
	quad3.set_aspect(Data.Aspect.FITNESS)
	quad4.set_aspect(Data.Aspect.FOCUS)
	bar_awa.set_aspect(Data.Aspect.AWARENESS)
	bar_spi.set_aspect(Data.Aspect.SPIRIT)
	bar_fit.set_aspect(Data.Aspect.FITNESS)
	bar_foc.set_aspect(Data.Aspect.FOCUS)
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
	# uncomment to always put -2s at the end
	deck.sort_custom(shuffle_last)
	card.visible = false
	update_dist()
	
func shuffle_last(a: Data.Card, b: Data.Card) -> bool:
	return a.need_shuffle()

func draw() -> void:
	var new_card: Data.Card = deck.pop_back()
	update_card(new_card)
	if new_card.need_shuffle():
		shuffle()
	card.visible = true
	update_dist()
	
func update_dist() -> void:
	bar_awa.update_dist(deck)
	bar_spi.update_dist(deck)
	bar_fit.update_dist(deck)
	bar_foc.update_dist(deck)

func _on_reshuffle_pressed() -> void:
	reshuffle()

func _on_draw_pressed() -> void:
	draw()
