extends RigidBody2D

func _ready():
	var mod_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mod_types[randi() % mod_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
