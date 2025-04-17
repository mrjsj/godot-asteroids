extends Node3D

func _ready() -> void:
    Global.on_gun_fired.connect(_spawn_projectile)
    
func _spawn_projectile(emitter: Node3D) -> void:
    var projectile := Projectile.init(
        emitter.position,
        emitter.rotation,
    )
    add_child(projectile)
