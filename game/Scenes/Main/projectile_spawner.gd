extends Node3D

func _ready() -> void:
	Global.on_gun_fired.connect(Callable(self, "_spawn_projectile"))
	
func _spawn_projectile(at_position: Vector3, in_direction: Vector3) -> void:
	var projectile := Projectile.init(
		at_position,
		in_direction,
	)
	add_child(projectile)
