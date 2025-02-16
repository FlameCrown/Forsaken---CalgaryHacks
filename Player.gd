extends Node2D

# Player properties
var speed = 200  # Speed at which the player moves
var health = 1000
var max_health = 1000
var xp = 0
var max_xp = 1000
var damage = 10  # Damage dealt by the player

# Reference to the sprite and health bars
onready var sprite = $Sprite
onready var health_bar = $HealthBar
onready var xp_bar = $XPBar
onready var hitbox = $Hitbox

# Input detection for movement
var velocity = Vector2.ZERO

# Melee attack variables
var attack_range = 50
var attack_timer = 0.0
var attack_cooldown = 0.5  # Time before player can attack again

# Called every frame
func _process(delta):
	handle_movement(delta)
	handle_attack(delta)

	# Update health and XP bars
	health_bar.value = health
	xp_bar.value = xp

# Handle player movement using WASD keys
func handle_movement(delta):
	velocity = Vector2.ZERO

	# WASD movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	velocity = velocity.normalized() * speed
	position += velocity * delta

# Handle player attack when left mouse button is pressed
func handle_attack(delta):
	if Input.is_action_just_pressed("attack") and attack_timer <= 0:
		attack_timer = attack_cooldown
		perform_attack()

	# Cooldown timer for the next attack
	attack_timer -= delta

# Perform the attack and check for enemies in the hitbox
func perform_attack():
	# Detect enemies in the attack range (hitbox)
	var enemies_in_range = get_enemies_in_range()

	for enemy in enemies_in_range:
		if enemy.is_in_group("enemies"):
			enemy.take_damage(damage)  # Deal damage to the enemy
			xp += 10  # Gain XP for attacking

# Check for enemies in the attack range (hitbox)
func get_enemies_in_range() -> Array:
	var enemies_in_range = []
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if hitbox.get_global_position().distance_to(enemy.global_position) < attack_range:
			enemies_in_range.append(enemy)
	return enemies_in_range

# Function to take damage
func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

# Handle player death
func die():
	queue_free()  # Remove player from the scene
	print("Player died!")
