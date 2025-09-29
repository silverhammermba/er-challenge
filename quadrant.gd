# Copyright (C) 2025 Maxwell Anselm
# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

class_name Quadrant extends Control

const Data = preload("data.gd")

@onready var number_label: Label = $Number
@onready var aspect_label: Label = $Aspect
@onready var color_rect: ColorRect = $Color

var _color: Color = Color.BLACK:
	get:
		return _color
	set(value):
		_color = value

func set_aspect(value: Data.Aspect) -> void:
	aspect_label.text = Data.aspect_name(value)
	var color := Data.aspect_color(value)
	color_rect.color = color
	aspect_label.add_theme_color_override("font_outline_color", color)

func set_number(value: int) -> void:
	if value > 0:
		number_label.text = "%+d" % value
	else:
		number_label.text = "%d" % value
