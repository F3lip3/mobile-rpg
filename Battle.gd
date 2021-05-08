extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var buttons = $UI/BattleActionButtons
onready var fadeAnimation = $FadeAnimation
onready var nextEnemyButton = $UI/CenterContainer/NextEnemyButton
onready var enemyPosition = $EnemyPosition

func _ready():
	randomize()
	nextEnemyButton.hide()
	create_new_enemy()
	start_player_turn()

func start_enemy_turn():
	buttons.hide()	
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
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

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextEnemyButton.show()
	buttons.hide()

func _on_NextEnemyButton_pressed():
	nextEnemyButton.hide()
	fadeAnimation.play("FadeToNewEnemy")
	yield(fadeAnimation, "animation_finished")
	var player = BattleUnits.Player
	player.ap = player.max_ap
	buttons.show()
	create_new_enemy()
