extends Node3D
class_name Projectile

const PROJECTILE := preload("res://Scenes/Projectile/projectile.tscn")
@export var speed := 50

static func init(position: Vector3, rotation: Vector3) -> Projectile:
	var projectile : Projectile = PROJECTILE.instantiate()
	projectile.position = position
	projectile.rotation = rotation
	
	return projectile

func _process(delta: float) -> void:
	var direction := self.transform.basis.y
	
	self.position += direction.normalized() * (speed + 1) * delta

func _on_timer_timeout() -> void:
	self.queue_free()
