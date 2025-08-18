extends Node

enum Aspect { FITNESS, SPIRIT, FOCUS, AWARENESS }

func aspect_name(aspect: Aspect) -> String:
	match aspect:
		Aspect.FITNESS:
			return "Fitness"
		Aspect.SPIRIT:
			return "Spirit"
		Aspect.FOCUS:
			return "Focus"
		_: # awareness
			return "Awareness"
				
func aspect_color(aspect: Aspect) -> Color:
	match aspect:
		Aspect.FITNESS:
			return Color.RED
		Aspect.SPIRIT:
			return Color.YELLOW
		Aspect.FOCUS:
			return Color.GREEN
		_: # awareness
			return Color.BLUE
