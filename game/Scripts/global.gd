extends Node

@warning_ignore("unused_signal")
signal on_gun_fired(emitter: Player)

const CAMERA_SIZE : float = 100
const TELEPORTATION_LEEWAY := 3

func get_viewport_aspect_ratio() -> float:
    var vp_width : float = ProjectSettings.get_setting("display/window/size/viewport_width")
    var vp_height : float = ProjectSettings.get_setting("display/window/size/viewport_height")   
    return vp_width / vp_height   

func keep_object_inside_world_boundaries(pos: Vector3) -> Vector3:        
    var aspect_ratio : float = get_viewport_aspect_ratio()
    var half_camera_size := CAMERA_SIZE / 2.0 + TELEPORTATION_LEEWAY

    if (
        pos.y > half_camera_size or
        pos.y < -half_camera_size
    ):
        pos.y *= -1
        
    if (
        pos.x > half_camera_size * aspect_ratio or
        pos.x < -half_camera_size * aspect_ratio 
    ):
        pos.x *= -1

    return pos
