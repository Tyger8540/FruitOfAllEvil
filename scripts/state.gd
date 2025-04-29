extends Node


var location: String = "intro"
var section: String = "C2_intro1"
var vendor: String = ""
var dialogue_ready: bool = true  # Should be set to true by default
var dialogue_file: String = "res://dialogue/circle2.dialogue"
var level_defeated: bool = false
var cutscene_speaker: String = ""

var circle_num: int = 2
var next_boss: String = "Cerberus"  # MAKE SURE FIRST LETTER IS CAPITALIZED
var current_boss: String = ""
var boss_queued: bool = false

var next_vendor: String = ""
var previous_vendor: String = ""

var received_blender: bool = false
var talked_to_virgil: bool = false
