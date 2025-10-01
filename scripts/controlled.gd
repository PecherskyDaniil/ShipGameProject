extends Node2D
var speed:float=0
var max_speed:float=500
var move_vector:Vector2=Vector2(0,0)
var flame_size:Vector2=Vector2(1,1)
var flame_max_size:float=5
@onready var sprite:Sprite2D=get_node("ShipArea/ShipSprite/ShieldSprite")
@onready var flame:Sprite2D=get_node("ShipArea/ShipSprite/FlameSprite")



func _process(delta):
	var label=get_node("PositionLabel")
	label.text="Position %v" % position
	flame.rotation=rotation+PI
	flame.scale=flame_size
	flame_size-=Vector2(0.05,0.05)
	if flame_size.x<0 or flame_size.y<0:
		flame_size=Vector2(0,0)
	speed-=2
	if speed<0:
		speed=0
	if move_vector.x>0:
		move_vector.x-=2
	elif move_vector.x<0:
		move_vector.x+=2
	if move_vector.y>0:
		move_vector.y-=2
	elif move_vector.y<0:
		move_vector.y+=2
	var x=speed*cos(get_node("ShipArea/ShipSprite").rotation+PI/2)
	var y=speed*sin(get_node("ShipArea/ShipSprite").rotation+PI/2)
	#position+=speed*delta*Vector2(x,y).normalized()
	position+=delta*move_vector
	if Input.is_action_pressed("ui_left"):
		get_node("ShipArea/ShipSprite").rotation-=0.05
	if Input.is_action_pressed("ui_right"):
		get_node("ShipArea/ShipSprite").rotation+=0.05
	if Input.is_action_pressed("ui_up"):
		flame_size+=Vector2(0.1,0.1)
		flame_size=flame_size.limit_length(flame_max_size)
		move_vector.x+=10*cos(get_node("ShipArea/ShipSprite").rotation+PI/2)
		move_vector.y+=10*sin(get_node("ShipArea/ShipSprite").rotation+PI/2)
		move_vector=move_vector.limit_length(max_speed)
		speed+=5
		if speed>max_speed:
			speed=max_speed
	if Input.is_action_pressed("ui_down"):
		speed-=5
		if speed<0:
			speed=0
			
func damage(pos,vel):
	sprite.visible=false
	var impulse=30000/abs((pos.x-position.x)**2+(pos.y-position.y)**2)
	move_vector-=(Vector2(pos-global_position)*impulse-vel)
	#position+=move_vector*0.01
	print(Vector2(pos-global_position),Vector2(pos-global_position)*impulse)
