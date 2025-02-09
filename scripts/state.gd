extends Node


var location: String = "intro"
var section: String = "C0_intro"
var vendor: String = ""
var dialogue_ready: bool = true
var dialogue_file: String = "res://dialogue/prologue.dialogue"
var level_defeated: bool = false

var circle_num: int = 0
var next_boss: String = "Charon"
var boss_queued: bool = true
