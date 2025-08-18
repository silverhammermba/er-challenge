class_name Bar extends ColorRect

const Data = preload("data.gd")

@onready var sub1: ColorRect = $Sub
@onready var sub2: ColorRect = $Sub2
@onready var sub3: ColorRect = $Sub3

var _aspect: Data.Aspect = Data.Aspect.FITNESS

func _ready() -> void:
	sub1.color = Data.effect_color(Data.Effect.CREST)
	sub2.color = Data.effect_color(Data.Effect.MOUNTAIN)
	sub3.color = Data.effect_color(Data.Effect.SUN)

func set_aspect(value: Data.Aspect) -> void:
	_aspect = value
	color = Data.aspect_color(_aspect)

func update_sub_dist(crest: int, mountain: int, sun: int) -> void:
	# if all equal, hide the subbars rather than completely cover the bar
	if crest == mountain && mountain == sun:
		sub1.anchor_right = 0.0
		sub2.anchor_right = 0.0
		sub3.anchor_right = 0.0
		return
	var most: float = float(max(crest, mountain, sun))
	sub1.anchor_right = crest / most
	sub2.anchor_right = mountain / most
	sub3.anchor_right = sun / most
