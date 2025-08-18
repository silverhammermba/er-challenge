class_name Quadrant extends Control

@onready var number_label: Label = $Number
@onready var aspect_label: Label = $Aspect
@onready var color_rect: ColorRect = $Color

var _color: Color = Color.BLACK:
	get:
		return _color
	set(value):
		_color = value
		color_rect.color = value
		aspect_label.add_theme_color_override("font_outline_color", value)

var _aspect: Globals.Aspect = Globals.Aspect.FITNESS
var _number: int = 0

func set_aspect(value: Globals.Aspect) -> void:
	_aspect = value
	_color = Globals.aspect_color(_aspect)
	aspect_label.text = Globals.aspect_name(_aspect)
		
func set_number(value: int) -> void:
	_number = value
	number_label.text = "%+d" % _number
