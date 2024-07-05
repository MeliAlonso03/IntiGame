extends KinematicBody2D

# Variables de configuración
var speed = 500
var direction = Vector2.ZERO
var screen_size = Vector2.ZERO
var target_direction = Vector2.ZERO
var lerp_factor = 0.10  # Ajusta este valor para cambiar la suavidad del movimiento

# Timer para cambiar la dirección
onready var direction_timer = Timer.new()

func _ready():
	# Configurar el timer
	direction_timer.wait_time = 2.0
	direction_timer.connect("timeout", self, "_on_DirectionTimer_timeout")
	add_child(direction_timer)
	direction_timer.start()
	# Obtener el tamaño de la pantalla
	screen_size = get_viewport_rect().size
	# Generar una dirección inicial
	change_direction()

func _process(delta):
	# Interpolación suave de la dirección
	direction = lerp_vector(direction, target_direction, lerp_factor)
	# Mover la ratita
	var velocity = direction * speed
	move_and_slide(velocity)
	# Clamar la posición para que la ratita no se salga de la pantalla
	position.x = clamp(position.x, 50, 420)
	position.y = clamp(position.y, 50, 680)

func _on_DirectionTimer_timeout():
	change_direction()

func change_direction():
	# Cambiar la dirección objetivo a un vector aleatorio
	target_direction.x = rand_range(-1, 1)
	target_direction.y = rand_range(-1, 1)
	target_direction = target_direction.normalized()

func lerp_vector(a: Vector2, b: Vector2, weight: float) -> Vector2:
	return a + (b - a) * weight

func pickup():
	call_deferred("queue_free")
