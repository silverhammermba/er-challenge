class_name Bars extends Control

const Data = preload("data.gd")

@onready var bar1: Bar = $BarContainer/Bar
@onready var bar2: Bar = $BarContainer/Bar2
@onready var bar3: Bar = $BarContainer/Bar3
@onready var bar4: Bar = $BarContainer/Bar4
@onready var label1: Label = $Label
@onready var label2: Label = $Label2
@onready var label3: Label = $Label3
@onready var label4: Label = $Label4

var _aspect: Data.Aspect = Data.Aspect.FITNESS

func flip_text() -> void:
	label1.scale.x = -1
	label2.scale.x = -1
	label3.scale.x = -1
	label4.scale.x = -1
	var width = label1.anchor_right - label1.anchor_left
	label1.anchor_left += width
	label1.anchor_right += width
	label2.anchor_left += width
	label2.anchor_right += width
	label3.anchor_left += width
	label3.anchor_right += width
	label4.anchor_left += width
	label4.anchor_right += width

func set_aspect(value: Data.Aspect) -> void:
	_aspect = value
	bar1.set_aspect(_aspect)
	bar2.set_aspect(_aspect)
	bar3.set_aspect(_aspect)
	bar4.set_aspect(_aspect)

func update_dist(deck: Array[Data.Card]) -> void:
	var counts: Dictionary[int, int] = {-2: 0, -1: 0, 0: 0, 1: 0}
	var effects: Dictionary[int, Variant] = {
		-2: {Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		-1: {Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		0: {Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		1: {Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0}
	}
	for card in deck:
		var asp: int = card.aspect(_aspect)
		counts[asp] += 1
		effects[asp][card.effect] += 1
	var most: float = float(max(counts[-2], counts[-1], counts[0], counts[1]))
	bar1.anchor_right = counts[1] / most
	bar2.anchor_right = counts[0] / most
	bar3.anchor_right = counts[-1] / most
	bar4.anchor_right = counts[-2] / most
	bar1.update_sub_dist(effects[1][Data.Effect.CREST], effects[1][Data.Effect.MOUNTAIN], effects[1][Data.Effect.SUN])
	bar2.update_sub_dist(effects[0][Data.Effect.CREST], effects[0][Data.Effect.MOUNTAIN], effects[0][Data.Effect.SUN])
	bar3.update_sub_dist(effects[-1][Data.Effect.CREST], effects[-1][Data.Effect.MOUNTAIN], effects[-1][Data.Effect.SUN])
	bar4.update_sub_dist(effects[-2][Data.Effect.CREST], effects[-2][Data.Effect.MOUNTAIN], effects[-2][Data.Effect.SUN])
