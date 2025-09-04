# Copyright (C) 2025 Maxwell Anselm
# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

# NEVER REORDER THESE. IT WILL UNDETECTABLY BREAK SAVED GAMES
enum Aspect { FITNESS, SPIRIT, FOCUS, AWARENESS }
enum Effect { CREST, MOUNTAIN, SUN }

class Card:
	var fitness: int = 0
	var spirit: int = 0
	var focus: int = 0
	var awareness: int = 0
	var effect: Effect = Effect.CREST

	const fitness_save_key = "fitness"
	const spirit_save_key = "spirit"
	const focus_save_key = "focus"
	const awareness_save_key = "awareness"
	const effect_save_key = "effect"

	func _init(awa: int, spi: int, fit: int, foc: int, eff: Effect) -> void:
		fitness = fit
		spirit = spi
		focus = foc
		awareness = awa
		effect = eff

	func need_shuffle() -> bool:
		return fitness == -2 or spirit == -2 or focus == -2 or awareness == -2

	func aspect(asp: Aspect) -> int:
		match asp:
			Aspect.FITNESS:
				return fitness
			Aspect.SPIRIT:
				return spirit
			Aspect.FOCUS:
				return focus
			_: # awareness
				return awareness
	
	func save_data() -> Dictionary[String, int]:
		return {
			fitness_save_key: fitness,
			spirit_save_key: spirit,
			focus_save_key: focus,
			awareness_save_key: awareness,
			effect_save_key: effect
		}
	
	static func load(data: Dictionary) -> Card:
		if fitness_save_key not in data or data[fitness_save_key] is not float:
			print("Ignoring saved card. Need numeric ", fitness_save_key, " in ", data)
			return null
		var fit: int = data[fitness_save_key]
		if spirit_save_key not in data or data[spirit_save_key] is not float:
			print("Ignoring saved card. Need numeric ", spirit_save_key, " in ", data)
			return null
		var spi: int = data[spirit_save_key]
		if focus_save_key not in data or data[focus_save_key] is not float:
			print("Ignoring saved card. Need numeric ", focus_save_key, " in ", data)
			return null
		var foc: int = data[focus_save_key]
		if awareness_save_key not in data or data[awareness_save_key] is not float:
			print("Ignoring saved card. Need numeric ", awareness_save_key, " in ", data)
			return null
		var awa: int = data[awareness_save_key]
		if effect_save_key not in data or data[effect_save_key] is not float:
			print("Ignoring saved card. Need numeric ", effect_save_key, " in ", data)
			return null
		var eff: int = data[effect_save_key]

		return new(awa, spi, fit, foc, eff)

static var cards: Array[Card] = [
	Card.new(1, 1, 0, -2, Effect.CREST),
	Card.new(0, 1, -1, 0, Effect.CREST),
	Card.new(-1, 0, 1, 0, Effect.SUN),
	Card.new(0, -1, 0, 1, Effect.CREST),
	Card.new(0, 0, -1, 1, Effect.MOUNTAIN),
	Card.new(-1, 1, 1, -1, Effect.MOUNTAIN),
	Card.new(-1, 0, 0, -1, Effect.MOUNTAIN),
	Card.new(-1, -1, 0, 0, Effect.CREST),
	Card.new(0, 1, -2, 1, Effect.SUN),
	Card.new(0, 1, 0, -1, Effect.MOUNTAIN),
	Card.new(0, -1, -1, 0, Effect.MOUNTAIN),
	Card.new(0, -1, 0, -1, Effect.SUN),
	Card.new(1, -1, -1, 1, Effect.MOUNTAIN),
	Card.new(1, -1, 0, 0, Effect.MOUNTAIN),
	Card.new(0, -1, 1, 0, Effect.SUN),
	Card.new(1, -2, 1, 0, Effect.CREST),
	Card.new(-2, 0, 1, 1, Effect.SUN),
	Card.new(-1, 0, 0, 1, Effect.CREST),
	Card.new(-1, 1, 0, 0, Effect.SUN),
	Card.new(0, 0, -1, -1, Effect.SUN),
	Card.new(0, 0, 1, -1, Effect.CREST),
	Card.new(1, 0, 0, -1, Effect.SUN),
	Card.new(-1, 0, -1, 0, Effect.CREST),
	Card.new(1, 0, -1, 0, Effect.MOUNTAIN)
]

static func aspect_name(aspect: Aspect) -> String:
	match aspect:
		Aspect.FITNESS:
			return "Fitness"
		Aspect.SPIRIT:
			return "Spirit"
		Aspect.FOCUS:
			return "Focus"
		_: # awareness
			return "Awareness"

static func aspect_color(aspect: Aspect) -> Color:
	match aspect:
		Aspect.FITNESS:
			return Color("ba2b26")
		Aspect.SPIRIT:
			return Color("e0af26")
		Aspect.FOCUS:
			return Color("4062a1")
		_: # awareness
			return Color("2b9243")

static func effect_color(effect: Effect) -> Color:
	match effect:
		Effect.CREST:
			return Color("98212c")
		Effect.MOUNTAIN:
			return Color("224879")
		_: # sun
			return Color("db8426")
