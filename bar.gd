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

func update_sub_dist(counts: Dictionary[Data.Effect, int]) -> void:
	var most: int = counts.values().max()
	var denom := float(most)
	sub1.anchor_right = counts[Data.Effect.CREST] / denom
	sub2.anchor_right = counts[Data.Effect.MOUNTAIN] / denom
	sub3.anchor_right = counts[Data.Effect.SUN] / denom
