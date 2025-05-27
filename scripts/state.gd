extends Node


#region Circle 0 - Prologue
var location: String = "intro"
var section: String = "C0_intro"
var vendor: String = ""
var dialogue_ready: bool = true  # Should be set to true by default
var dialogue_file: String = "res://dialogue/prologue.dialogue"
var level_defeated: bool = false
var cutscene_speaker: String = ""

var circle_num: int = 0
var next_boss: String = "Charon"  # MAKE SURE FIRST LETTER IS CAPITALIZED
var current_boss: String = ""
var boss_queued: bool = false

var next_vendor: String = ""
var previous_vendor: String = ""

var received_blender: bool = false
var talked_to_virgil: bool = false
#endregion

#region Circle 1 - Limbo
#var location: String = "intro"
#var section: String = "C1_intro"
#var vendor: String = ""
#var dialogue_ready: bool = true  # Should be set to true by default
#var dialogue_file: String = "res://dialogue/circle1.dialogue"
#var level_defeated: bool = false
#var cutscene_speaker: String = ""
#
#var circle_num: int = 1
#var next_boss: String = "Charon"  # MAKE SURE FIRST LETTER IS CAPITALIZED
#var current_boss: String = ""
#var boss_queued: bool = false
#
#var next_vendor: String = ""
#var previous_vendor: String = ""
#
#var received_blender: bool = false
#var talked_to_virgil: bool = false
#endregion

#region Circle 2 - Lust
#var location: String = "intro"
#var section: String = "C2_intro"
#var vendor: String = ""
#var dialogue_ready: bool = true  # Should be set to true by default
#var dialogue_file: String = "res://dialogue/circle2.dialogue"
#var level_defeated: bool = false
#var cutscene_speaker: String = ""
#
#var circle_num: int = 2
#var next_boss: String = "Cerberus"  # MAKE SURE FIRST LETTER IS CAPITALIZED
#var current_boss: String = ""
#var boss_queued: bool = false
#
#var next_vendor: String = ""
#var previous_vendor: String = ""
#
#var received_blender: bool = false
#var talked_to_virgil: bool = false
#endregion
