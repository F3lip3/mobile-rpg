extends Node2D

onready var hpLabel = $HPLabel
onready var animation = $AnimationPlayer

signal died

var hp = 25 setget set_hp

func set_hp(new_hp):
	hp = new_hp
	hpLabel.text = str(hp) + "hp"
	if hp <= 0:
		emit_signal("died")
		queue_free()
	else:
		animation.play("Shake")
		yield(animation, "animation_finished")
		animation.play("Attack")
		yield(animation, "animation_finished")
		var battle = get_tree().current_scene
		var player = battle.get_node("PlayerStats")
		player.hp -= 3
