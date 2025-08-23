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
var bars: Array[Bar]

func _ready() -> void:
	# matches up bar2: 0, bar1: 1, bar4: -2, bar3: -1
	bars = [bar2, bar1, bar4, bar3]

func flip_text() -> void:
	label1.scale.x = -1
	label2.scale.x = -1
	label3.scale.x = -1
	label4.scale.x = -1
	var width := label1.anchor_right - label1.anchor_left
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
	for bar in bars:
		bar.set_aspect(_aspect)

func update_dist(deck: Array[Data.Card]) -> void:
	var counts: Array[int] = [0, 0, 0, 0]
	var effects: Array[Dictionary] = [
		{Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		{Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		{Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0},
		{Data.Effect.SUN: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.CREST: 0}
	]
	for card in deck:
		var asp: int = card.aspect(_aspect)
		counts[asp] += 1
		effects[asp][card.effect] += 1
	var most: int = max(counts[-2], counts[-1], counts[0], counts[1])
	var denom := float(most)
	var effect: Dictionary[Data.Effect, int] = {}
	for idx in range(effects.size()):
		bars[idx].anchor_right = counts[idx] / denom
		effect.assign(effects[idx])
		bars[idx].update_sub_dist(effect)
