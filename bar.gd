# Copyright (C) 2025 Maxwell Anselm
# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

class_name Bar extends Control

const Data = preload("data.gd")

@onready var color: ColorRect = $Color
@onready var sub1: ColorRect = $Color/MarginContainer/VBoxContainer/Control/Sub
@onready var sub2: ColorRect = $Color/MarginContainer/VBoxContainer/Control2/Sub2
@onready var sub3: ColorRect = $Color/MarginContainer/VBoxContainer/Control3/Sub3
@onready var margin: MarginContainer = $Color/MarginContainer

var _flipped := false

func _ready() -> void:
	sub1.color = Data.effect_color(Data.Effect.CREST)
	sub2.color = Data.effect_color(Data.Effect.MOUNTAIN)
	sub3.color = Data.effect_color(Data.Effect.SUN)

func flip() -> void:
	_flipped = true
	margin.add_theme_constant_override("margin_left", 5)
	margin.remove_theme_constant_override("margin_right")

func set_aspect(value: Data.Aspect) -> void:
	color.color = Data.aspect_color(value)

func update_sub_dist(counts: Dictionary[Data.Effect, int]) -> void:
	var most: int = counts.values().max()
	var denom := float(most)
	if _flipped:
		sub1.anchor_left = 1 - counts[Data.Effect.CREST] / denom
		sub2.anchor_left = 1 - counts[Data.Effect.MOUNTAIN] / denom
		sub3.anchor_left = 1 - counts[Data.Effect.SUN] / denom
	else:
		sub1.anchor_right = counts[Data.Effect.CREST] / denom
		sub2.anchor_right = counts[Data.Effect.MOUNTAIN] / denom
		sub3.anchor_right = counts[Data.Effect.SUN] / denom
