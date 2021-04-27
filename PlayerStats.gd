extends Node

var max_ap = 3
var max_hp = 25
var max_mp = 10

var ap = max_ap setget set_ap
var hp = max_hp setget set_hp
var mp = max_mp setget set_mp

signal ap_changed(value)
signal hp_changed(value)
signal mp_changed(value)

signal end_turn

func set_ap(value):
	ap = min(value, max_ap)
	emit_signal("ap_changed", ap)
	
func set_hp(value):
	hp = min(value, max_hp)
	emit_signal("hp_changed", hp)
	
func set_mp(value):
	mp = min(value, max_mp)
	emit_signal("mp_changed", mp)