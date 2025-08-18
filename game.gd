extends Control

@onready var quad1: Quadrant = $CardArea/CardContainer/Card/Quadrant
@onready var quad2: Quadrant = $CardArea/CardContainer/Card/Quadrant2
@onready var quad3: Quadrant = $CardArea/CardContainer/Card/Quadrant3
@onready var quad4: Quadrant = $CardArea/CardContainer/Card/Quadrant4

func _ready() -> void:
	quad1.set_aspect(Globals.Aspect.FOCUS)
	quad2.set_aspect(Globals.Aspect.SPIRIT)
	quad3.set_aspect(Globals.Aspect.FITNESS)
	quad4.set_aspect(Globals.Aspect.AWARENESS)
	quad1.set_number(-2)
	quad2.set_number(-1)
	quad3.set_number(0)
	quad4.set_number(1)
