enum Aspect { FITNESS, SPIRIT, FOCUS, AWARENESS }
enum Effect { CREST, MOUNTAIN, SUN }

class Card:
	var fitness: int = 0
	var spirit: int = 0
	var focus: int = 0
	var awareness: int = 0
	var effect: Effect = Effect.CREST

	func _init(awa: int, spi: int, fit: int, foc: int, eff: Effect) -> void:
		fitness = fit
		spirit = spi
		focus = foc
		awareness = awa
		effect = eff

	func need_shuffle() -> bool:
		return fitness == -2 || spirit == -2 || focus == -2 || awareness == -2

var cards: Array[Card] = [
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
			return Color.RED
		Aspect.SPIRIT:
			return Color.ORANGE
		Aspect.FOCUS:
			return Color.GREEN
		_: # awareness
			return Color.BLUE

static func effect_color(effect: Effect) -> Color:
	match effect:
		Effect.CREST:
			return Color.DARK_RED
		Effect.MOUNTAIN:
			return Color.DARK_BLUE
		_: # sun
			return Color.DARK_ORANGE
