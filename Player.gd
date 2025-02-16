extends CharacterBody2D

@onready var sync = $MultiplayerSynchronizer
@onready var anim = $AnimatedSprite2D
@onready var hp = $Health
@onready var damage = $HurtBox2D
@onready var hurtbox = $Hurtbox
@onready var hitbox = $Hitbox

@rpc func sync_position(pos: Vector2):
    global_position = pos
    
func _ready():
    # Setup the synchronizer (this may be done automatically depending on the setup)
    
    
    # Ensure the local player controls their own character
    if is_multiplayer_authority():
        set_multiplayer_authority(get_tree().network_peer.get_unique_id())  # Ensure local control

func _process(delta: float) -> void:
    if is_multiplayer_authority():
        velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
        if velocity.x == 1:
            anim.play("walk_right")
        elif velocity.x == -1:
            anim.play("walk_left")
        elif velocity.y == 1:
            anim.play("walk_up")
        elif velocity.y == -1:
            anim.play("walk_right")
        move_and_slide()
    
