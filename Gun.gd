extends Area2D

export var bullet_speed = 1000
export var fire_rate = 0.2

var bullet = preload("res://MyBullet.tscn")
var can_fire = true

func _process(delta):
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $Bulletpoint.get_global_position()
		bullet_instance.rotation = rotation
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
