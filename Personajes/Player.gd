extends Area2D


# Declare member variables here. Examples:
var velocity = Vector2.ZERO
var speed = 350


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.center_window()
	position = Vector2(100,100)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y += -1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	position += velocity
	
	if position.x >= 480:
		position.x = 480
	if position.x <= 0:
		position.x =0
	if position.y >= 720:
		position.y = 720
	if position.y <= 0:
		position.y = 0 
		
		
	print (velocity)
	if velocity.length() != 0: 
		$AnimatedSprite.play("default")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("default")

