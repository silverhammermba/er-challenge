# Copyright (C) 2025 Maxwell Anselm
# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

class_name CardDisplay extends VBoxContainer

const Data = preload("data.gd")

@onready var quad1: Quadrant = $GridContainer/Quadrant
@onready var quad2: Quadrant = $GridContainer/Quadrant2
@onready var quad3: Quadrant = $GridContainer/Quadrant3
@onready var quad4: Quadrant = $GridContainer/Quadrant4
@onready var effect: ColorRect = $Effect
@onready var effect_icon: TextureRect = $Effect/Icon
@onready var effect_shuffle: TextureRect = $Effect/Shuffle

var crest_icon: Texture2D = preload("res://crest.svg")
var mountain_icon: Texture2D = preload("res://mountain.svg")
var sun_icon: Texture2D = preload("res://sun.svg")

func _ready() -> void:
	quad1.set_aspect(Data.Aspect.AWARENESS)
	quad2.set_aspect(Data.Aspect.SPIRIT)
	quad3.set_aspect(Data.Aspect.FITNESS)
	quad4.set_aspect(Data.Aspect.FOCUS)

func update(new_card: Data.Card) -> void:
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
