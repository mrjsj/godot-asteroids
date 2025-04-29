extends Node3D

class_name Player

@onready var gun : Marker3D = $Gun

@export var speed := 0.02
@export var deceleration_factor := 0.98
@export var max_velocity := 0.45
@export var max_acceleration := 0.01

const CAMERA_SIZE : float = 100

var velocity := Vector3.ZERO
var acceleration := Vector3.ZERO

var input_up := false
var input_left := false
var input_right := false
var input_fire := false

func _process(_delta: float) -> void:
    
    self.input_up = Input.is_action_pressed("ui_up")
    self.input_left = Input.is_action_pressed("ui_left")
    self.input_right = Input.is_action_pressed("ui_right")
    self.input_fire = Input.is_action_just_pressed("ui_accept")
    
    if input_fire:
        Global.on_gun_fired.emit(self)
    
func _physics_process(delta: float) -> void:

    var forward := self.transform.basis.y

    if input_left:
        self.rotation.z += 1 * delta
    if input_right:
        self.rotation.z -= 1 * delta
    
    if input_up:
        acceleration += forward * speed * delta
    else:
        acceleration = Vector3.ZERO
        self.velocity *= self.deceleration_factor
    
    acceleration.x = clampf(acceleration.x, -max_acceleration, max_acceleration)
    acceleration.y = clampf(acceleration.y, -max_acceleration, max_acceleration)

    self.velocity += acceleration
    self.velocity.x = clampf(self.velocity.x, -max_velocity, max_velocity)
    self.velocity.y = clampf(self.velocity.y, -max_velocity, max_velocity)

    self.position += self.velocity

    self.position = Global.keep_object_inside_world_boundaries(self.position)

