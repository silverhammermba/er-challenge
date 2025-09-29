# Copyright (C) 2025 Maxwell Anselm
# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

class_name Bars extends GridContainer

const Data = preload("data.gd")

# we assume this starts visible
@onready var area1: Control = $Area
# we assume this starts invisible
@onready var area5: Control = $Area5
@onready var bar1: Bar = $Area/Bar
@onready var bar2: Bar = $Area2/Bar
@onready var bar3: Bar = $Area3/Bar
@onready var bar4: Bar = $Area4/Bar
@onready var bar5: Bar = $Area5/Bar
@onready var label1: Label = $Label
@onready var label2: Label = $Label2
@onready var label3: Label = $Label3
@onready var label4: Label = $Label4

var _flipped := false
var _aspect: Data.Aspect = Data.Aspect.FITNESS
var bars: Array[Bar]

func _ready() -> void:
	# matches up bar2: 0, bar1: 1, bar4: -2, bar3: -1
	bars = [bar2, bar1, bar4, bar3]

func flip() -> void:
	_flipped = true
	area1.visible = false
	area5.visible = true
	bars = [bar3, bar2, bar5, bar4]
	for bar in bars:
		bar.flip()

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
		if _flipped:
			bars[idx].anchor_left = 1 - counts[idx] / denom
		else:
			bars[idx].anchor_right = counts[idx] / denom
		effect.assign(effects[idx])
		bars[idx].update_sub_dist(effect)
