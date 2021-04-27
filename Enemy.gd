extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

onready var hpLabel = $HPLabel
onready var animation = $AnimationPlayer

signal died
signal end_turn

export(int) var hp = 25 setget set_hp
export(int) var damage = 4

func set_hp(new_hp):
	hp = new_hp
	if hpLabel != null:
		hpLabel.text = str(hp) + "hp"

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animation.play("Attack")
	yield(animation, "animation_finished")
	emit_signal("end_turn")

func deal_damage():
	BattleUnits.Player.hp -= damage

func is_dead():
	return hp <= 0
	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animation.play("Shake")

func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null
