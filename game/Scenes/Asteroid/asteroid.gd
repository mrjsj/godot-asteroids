extends Node3D

const spawn_areas := [
    {"from": Vector3(-95, 50, 2.5), "to": Vector3(95, 50, 2.5)},
    {"from": Vector3(-95, -50, 2.5), "to": Vector3(-95, -50, 2.5)},
    {"from": Vector3(-95, -50, 2.5), "to": Vector3(-95, 50, 2.5)},
    {"from": Vector3(95, -50, 2.5), "to": Vector3(95, 50, 2.5)},
]

var _has_properly_spawned := false
var velocity := Vector3.ZERO

func _ready() -> void:
    var rng := RandomNumberGenerator.new()
    var random_side := rng.randi_range(0, 3)
    
    var spawn_area : Dictionary = spawn_areas[random_side]
    
    var from_x : float = spawn_area["from"].x
    var to_x : float = spawn_area["to"].x
    
    var from_y : float = spawn_area["from"].y
    var to_y : float = spawn_area["to"].y

    var rng_x := rng.randf_range(from_x, to_x)
    var rng_y := rng.randf_range(from_y, to_y)
    
    self.position.x = rng_x
    self.position.y = rng_y
    
    self.velocity.x = -1 * sign(rng_x) * rng.randf_range(1.1, 1.30)
    self.velocity.y = -1 * sign(rng_y) * rng.randf_range(1.1, 1.30)
    


func _physics_process(delta: float) -> void:
    
    self.position += self.velocity * delta * 15
    
    if _has_properly_spawned:
        self.position = Global.keep_object_inside_world_boundaries(self.position)

func _on_timer_timeout() -> void:
    _has_properly_spawned = true
