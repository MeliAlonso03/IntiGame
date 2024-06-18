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
	get_input()
	position += velocity * delta
	
	position.x = clamp(position.x, 0, 480)
	position.y = clamp(position.y, 0, 720)
		
	process_animations()

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 
		
func process_animations():
	print (velocity)
	if velocity.length() != 0: 
		$AnimatedSprite.play("default")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("default")
