extends Node2D

@onready var player=get_node("player")
@onready var obstacle=get_node("obstacle/AsteroidArea")
@onready var enemy=get_node("enemy")
func _ready()->void:
	obstacle.damaged.connect(player.damage)
func _process(delta: float) -> void:
	enemy.seek(obstacle.global_position)
	enemy.flee(player.global_position)
