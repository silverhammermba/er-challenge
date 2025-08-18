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
@onready var bar_cst: ColorRect = $EffectBars/Bar
@onready var bar_mnt: ColorRect = $EffectBars/Bar2
@onready var bar_sun: ColorRect = $EffectBars/Bar3
@export var crest_icon: Texture2D
@export var mountain_icon: Texture2D
@export var sun_icon: Texture2D

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
	bar_cst.color = Data.effect_color(Data.Effect.CREST)
	bar_mnt.color = Data.effect_color(Data.Effect.MOUNTAIN)
	bar_sun.color = Data.effect_color(Data.Effect.SUN)
	reshuffle()

func update_card(new_card: Data.Card) -> void:
	quad1.set_number(new_card.awareness)
	quad2.set_number(new_card.spirit)
	quad3.set_number(new_card.fitness)
	quad4.set_number(new_card.focus)
	effect.color = Data.effect_color(new_card.effect)
	match new_card.effect:
		Data.Effect.CREST:
			effect_icon.texture = crest_icon
		Data.Effect.MOUNTAIN:
			effect_icon.texture = mountain_icon
		_: # sun
			effect_icon.texture = sun_icon
	effect_shuffle.visible = new_card.need_shuffle()

func shuffle() -> void:
	deck = Data.cards.duplicate()
	deck.shuffle()
	
func reshuffle() -> void:
	shuffle()
	# uncomment to always put -2s at the end
	#deck.sort_custom(shuffle_last)
	card.visible = false
	update_dist()
	
func shuffle_last(a: Data.Card, _b: Data.Card) -> bool:
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
	var counts: Dictionary[Data.Effect, int] = {Data.Effect.CREST: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.SUN: 0}
	for c in deck:
		counts[c.effect] += 1
	var most: float = float(max(counts[Data.Effect.CREST], counts[Data.Effect.MOUNTAIN], counts[Data.Effect.SUN]))
	bar_cst.anchor_top = 1 - counts[Data.Effect.CREST] / most
	bar_mnt.anchor_top = 1 - counts[Data.Effect.MOUNTAIN] / most
	bar_sun.anchor_top = 1 - counts[Data.Effect.SUN] / most
		

func _on_reshuffle_pressed() -> void:
	reshuffle()

func _on_draw_pressed() -> void:
	draw()
