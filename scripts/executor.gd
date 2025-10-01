extends Node2D


var axeleration:Vector2=Vector2(0,0)
var velocity:Vector2=Vector2(0,0)
var max_force:float=1000
var max_speed:float=400
var max_distance:float=100
@onready var window=get_parent().get_window()

func apply_force(force:Vector2):
	axeleration=force


func update(delta:float):
	velocity+=axeleration*delta
	velocity=velocity.limit_length(max_speed)
	global_position+=velocity*delta
	axeleration*=0
	rotation=velocity.angle()- PI/2

func _process(delta):
	update(delta)
	if global_position.x>window.size.x:
		global_position.x=0
	elif global_position.x<0:
		global_position.x=window.size.x
	if global_position.y>window.size.y:
		global_position.y=0
	elif global_position.y<0:
		global_position.y=window.size.y


func seek(target:Vector2):
	var direction=target-global_position
	var a=remap(direction.length(),0,max_distance,0,1)
	if not(direction.length()>max_distance*3):	
		var desired_velocity=direction.normalized()*max_speed
		var steering=(desired_velocity-velocity)
		steering=steering.limit_length(max_force)
		apply_force(steering*a)

func flee(target:Vector2):
	var direction=global_position-target
	#var a=remap(direction.length(),0,max_distance,0,1)
	if not(direction.length()>max_distance*1.5):	
		var desired_velocity=direction.normalized()*max_speed
		var steering=(desired_velocity-velocity)
		steering=steering.limit_length(max_force)
		apply_force(steering)
