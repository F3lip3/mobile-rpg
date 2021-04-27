extends Node2D

onready var hpLabel = $HPLabel
onready var animation = $AnimationPlayer

signal died
signal end_turn

var hp = 25 setget set_hp
var target = null

func set_hp(new_hp):
	hp = new_hp
	hpLabel.text = str(hp) + "hp"

func attack(_target) -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animation.play("Attack")
	self.target = _target
	yield(animation, "animation_finished")
	self.target = null
	emit_signal("end_turn")

func deal_damage():
	self.target.hp -= 4

func is_dead():
	return hp <= 0
	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animation.play("Shake")
