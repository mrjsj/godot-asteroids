extends Node3D

@export var speed := 0.02
@export var deceleration_factor := 0.98

@export var velocity := Vector3.ZERO
@export var acceleration := Vector3.ZERO

@onready var gun : Marker3D = $Gun

func _process(delta: float) -> void:
	
	var input := Input.is_action_pressed("ui_up")
	var left_input := Input.is_action_pressed("ui_left")
	var right_input := Input.is_action_pressed("ui_right")
	var fire := Input.is_action_just_pressed("ui_accept")
	
	var forward := self.transform.basis.y
	
	if fire:
		print(forward)
		Global.on_gun_fired.emit(self.gun.global_position, self.rotation)
	
	if left_input:
		self.rotation.z += 1 * delta
	if right_input:
		self.rotation.z -= 1 * delta
	
	if input:
		acceleration += forward * speed * delta
	else:
		acceleration = Vector3.ZERO
		self.velocity *= self.deceleration_factor
	
	
	self.velocity += acceleration
	self.velocity.x = clampf(self.velocity.x, -0.35, 0.35)
	self.velocity.y = clampf(self.velocity.y, -0.35, 0.35)
	#print(self.velocity)
		
	
	self.position += self.velocity
