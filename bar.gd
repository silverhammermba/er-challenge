class_name Bar extends ColorRect

const Data = preload("data.gd")

@onready var sub1: ColorRect = $Control/Sub
@onready var sub2: ColorRect = $Control/Sub2
@onready var sub3: ColorRect = $Control/Sub3

var _aspect: Data.Aspect = Data.Aspect.FITNESS

func _ready() -> void:
	sub1.color = Data.effect_color(Data.Effect.CREST)
	sub2.color = Data.effect_color(Data.Effect.MOUNTAIN)
	sub3.color = Data.effect_color(Data.Effect.SUN)

func set_aspect(value: Data.Aspect) -> void:
	_aspect = value
	color = Data.aspect_color(_aspect)

func update_sub_dist(crest: int, mountain: int, sun: int) -> void:
	var most: float = float(max(crest, mountain, sun))
	sub1.anchor_right = crest / most
	sub2.anchor_right = mountain / most
	sub3.anchor_right = sun / most
