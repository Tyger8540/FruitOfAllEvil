extends Node


var location: String = "intro"
var section: String = "C1_intro"
var vendor: String = ""
var dialogue_ready: bool = true
var dialogue_file: String = "res://dialogue/circle1.dialogue"
var level_defeated: bool = false
var cutscene_speaker: String = ""

var circle_num: int = 0
var next_boss: String = "Charon"
var boss_queued: bool = false

var next_vendor: String = ""
var previous_vendor: String = ""
