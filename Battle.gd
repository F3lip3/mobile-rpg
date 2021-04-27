extends Node

const BattleUnits = preload("res://BattleUnits.tres")

onready var buttons = $UI/BattleActionButtons

func _ready():
	start_player_turn()

func start_enemy_turn():
	buttons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()

func start_player_turn():
	buttons.show()
	var player = BattleUnits.Player
	if player != null:
		player.ap = player.max_ap
		yield(player, "end_turn")
		start_enemy_turn()

func _on_Enemy_died():
	buttons.hide()
