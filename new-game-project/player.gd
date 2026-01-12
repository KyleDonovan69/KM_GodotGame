extends CharacterBody2D

@export var speed := 250.0
@export var jump_velocity := -1000.0
@export var gravity := 1400.0
@export var world_width := 540.0

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# horizontal input
	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed

	move_and_slide()

	# auto jump when landing while falling
	if is_on_floor() and velocity.y >= 0:
		velocity.y = jump_velocity

	# screen wrap (edge-safe)
	var margin := 5.0
	if global_position.x < -margin:
		global_position.x = world_width + margin
	elif global_position.x > world_width + margin:
		global_position.x = -margin
