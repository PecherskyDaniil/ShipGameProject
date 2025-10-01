extends Area2D

signal damaged

var angle_velocity:float=1.6
var velocity:Vector2=Vector2(0,0)
var rng=RandomNumberGenerator.new()

@onready var window=get_parent().get_window()

@onready var size=get_node("AsteroidSprite").texture.get_size()

func _ready() -> void:
	velocity=Vector2(rng.randi_range(0,100),rng.randi_range(0,100))
	angle_velocity=rng.randf_range(0.1,05)
	
func _process(delta: float) -> void:
	
	global_position+=velocity*delta
	rotation+=angle_velocity*delta
	#print(window.size,position)
	if global_position.x>window.size.x-size.x/2 or global_position.x<0:
		velocity.x*=-1
	if global_position.y>window.size.y-size.y/2 or global_position.y<0:
		velocity.y*=-1
func on_area_entered(area:Area2D)->void:
	if area.get_parent() == get_parent().get_parent().get_node("player"):
		damaged.emit(global_position,velocity)
