extends Node


var location: String = "market"
var section: String = "C0_market"
var vendor: String = ""
var dialogue_ready: bool = false  # Should be set to true by default
var dialogue_file: String = "res://dialogue/prologue.dialogue"
var level_defeated: bool = false
var cutscene_speaker: String = ""

var circle_num: int = 0
var next_boss: String = "Charon"
var boss_queued: bool = false

var next_vendor: String = ""
var previous_vendor: String = ""

var received_blender: bool = false
var talked_to_virgil: bool = false
