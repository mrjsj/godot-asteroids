extends Node3D
class_name Projectile

const PROJECTILE := preload("res://Scenes/Projectile/projectile.tscn")

@export var speed := 50

static func init(spawn_position: Vector3, spawn_rotation: Vector3) -> Projectile:
    var projectile : Projectile = PROJECTILE.instantiate()
    projectile.position = spawn_position
    projectile.rotation = spawn_rotation
    
    return projectile

func _physics_process(delta: float) -> void:
    var direction := self.transform.basis.y
    
    self.position += direction * speed * delta

func _on_timer_timeout() -> void:
    self.queue_free()
