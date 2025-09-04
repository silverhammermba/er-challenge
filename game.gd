# This file is part of ER-Challenge.
# ER-Challenge is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# ER-Challenge is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with ER-Challenge. If not, see <https://www.gnu.org/licenses/>.

extends Control

const Data = preload("data.gd")

@onready var card: CardDisplay = $CardArea/CardContainer/Card
@onready var bar_awa: Bars = $BarArea2/Bars/Awareness
@onready var bar_spi: Bars = $BarArea/Bars/Spirit
@onready var bar_fit: Bars = $BarArea2/Bars/Fitness
@onready var bar_foc: Bars = $BarArea/Bars/Focus
@onready var bar_cst: ColorRect = $EffectBars/Bar
@onready var bar_mnt: ColorRect = $EffectBars/Bar2
@onready var bar_sun: ColorRect = $EffectBars/Bar3
@onready var scout_overlay: Button = $ScoutOverlay
@onready var scout_card: CardDisplay = $ScoutOverlay/CardDisplay

var deck: Array[Data.Card] = []
var current_card: Data.Card = null
var scout_index: int = -1
const save_version := 0
const save_path := "user://savegame.save"
const version_save_key := "version"
const deck_save_key := "deck"
const current_save_key := "current"

func _ready() -> void:
	bar_awa.set_aspect(Data.Aspect.AWARENESS)
	bar_awa.flip_text()
	bar_spi.set_aspect(Data.Aspect.SPIRIT)
	bar_fit.set_aspect(Data.Aspect.FITNESS)
	bar_fit.flip_text()
	bar_foc.set_aspect(Data.Aspect.FOCUS)
	bar_cst.color = Data.effect_color(Data.Effect.CREST)
	bar_mnt.color = Data.effect_color(Data.Effect.MOUNTAIN)
	bar_sun.color = Data.effect_color(Data.Effect.SUN)
	if not load_game():
		reshuffle()
	scout(false)

func shuffle() -> void:
	deck = Data.cards.duplicate()
	deck.shuffle()
	
func reshuffle() -> void:
	shuffle()
	# uncomment to always put -2s at the end of the deck (start of the array)
	#deck.sort_custom(shuffle_last)
	card.visible = false
	current_card = null
	update_dist()
	# just in case the user scouts after reshuffling, ensure they scout the same card after reloading
	save_game()
	
func shuffle_last(a: Data.Card, _b: Data.Card) -> bool:
	return a.need_shuffle()

func draw(can_shuffle: bool) -> void:
	current_card = deck.pop_back()
	card.update(current_card)
	if can_shuffle and current_card.need_shuffle():
		shuffle()
	card.visible = true
	update_dist()
	save_game()

func scout(active: bool) -> void:
	if active:
		if -scout_index <= deck.size():
			scout_card.update(deck[scout_index])
			scout_index -= 1
	else:
		scout_index = -1
	scout_overlay.visible = active
	
func update_dist() -> void:
	bar_awa.update_dist(deck)
	bar_spi.update_dist(deck)
	bar_fit.update_dist(deck)
	bar_foc.update_dist(deck)
	var counts: Dictionary[Data.Effect, int] = {Data.Effect.CREST: 0, Data.Effect.MOUNTAIN: 0, Data.Effect.SUN: 0}
	for c in deck:
		counts[c.effect] += 1
	var most: int = counts.values().max()
	var denom := float(most)
	bar_cst.anchor_right = counts[Data.Effect.CREST] / denom
	bar_mnt.anchor_right = counts[Data.Effect.MOUNTAIN] / denom
	bar_sun.anchor_right = counts[Data.Effect.SUN] / denom

func save_game() -> void:
	var save_file := FileAccess.open(save_path, FileAccess.WRITE)
	if not save_file:
		push_error("Couldn't save game! ", FileAccess.get_open_error())
		return
	var json_string := JSON.stringify(save_data())
	save_file.store_line(json_string)

func load_game() -> bool:
	# open save file
	if not FileAccess.file_exists(save_path):
		return false
	var save_file := FileAccess.open(save_path, FileAccess.READ)
	if not save_file:
		push_error("Couldn't load game! ", FileAccess.get_open_error())
		return false

	# load save dictionary
	var json_string := save_file.get_line()
	var json := JSON.new()
	var parse_result := json.parse(json_string)
	if not parse_result == OK:
		push_error("Failed to parse saved game JSON: ", json.get_error_message())
	if not json.data:
		return false
	if json.data is not Dictionary:
		print("Ignoring saved game. Save data is not an object.")
		return false
	var data: Dictionary = json.data

	# check version
	if version_save_key not in data:
		print("Ignoring saved game. No ", version_save_key, " found.")
		return false
	if data[version_save_key] is not float or data[version_save_key] != save_version:
		print("Ignoring saved game. Need ", version_save_key, " ", save_version, " but found ", data[version_save_key])
		return false

	if deck_save_key not in data or data[deck_save_key] is not Array:
		print("Ignoring saved game. Could not load ", deck_save_key, " array.")
		return false
	var saved_deck: Array = data[deck_save_key]

	var new_deck: Array[Data.Card] = []
	for card_data: Variant in saved_deck:
		if card_data is not Dictionary:
			print("Ignoring saved game. ", deck_save_key, " contains non-object card data: ", card_data)
			return false
		var card_dict: Dictionary = card_data
		var loaded_card := Data.Card.load(card_dict)
		if not loaded_card:
			# Card.load should have already logged the failure reason
			return false
		new_deck.append(loaded_card)

	card.visible = false
	if current_save_key in data:
		if data[current_save_key] is not Dictionary:
			print("Ignoring saved game. ", current_save_key, " is not an object.")
			return false
		var card_data: Dictionary = data[current_save_key]
		var loaded_card := Data.Card.load(card_data)
		if not loaded_card:
			return false
		current_card = loaded_card
		card.update(current_card)
		card.visible = true

	deck = new_deck
	update_dist()
	return true

func save_data() -> Dictionary:
	var saved_deck := []
	for c in deck:
		saved_deck.append(c.save_data())
	var data := {
		version_save_key: save_version,
		deck_save_key: saved_deck,
	}
	if current_card:
		data[current_save_key] = current_card.save_data()

	return data

func _on_reshuffle_pressed() -> void:
	reshuffle()

func _on_draw_pressed() -> void:
	draw(true)

func _on_scout_pressed() -> void:
	scout(true)

func _on_scout_overlay_pressed() -> void:
	scout(false)

func _on_discard_pressed() -> void:
	draw(false)
