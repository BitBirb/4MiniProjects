extends Node2D

# Script that applies camera boundaries (CollisionShape2D) to a 2D scene

@export var wall_thickness: float = 32.0
@export var margin: float = 0.0
@export var camera_path: NodePath # Set camera node in inspector

@onready var camera: Camera2D = get_node(camera_path) as Camera2D

func _ready():
	if camera == null:
		push_error("Camera2D not found at the given path.")
		return

	var screen_size = get_viewport().get_visible_rect().size
	var zoom = camera.zoom
	var visible_world_size = screen_size / zoom

	var half_width = visible_world_size.x / 2
	var half_height = visible_world_size.y / 2
	var cam_pos = camera.global_position

	var left = cam_pos.x - half_width - margin
	var right = cam_pos.x + half_width + margin
	var top = cam_pos.y - half_height - margin
	var bottom = cam_pos.y + half_height + margin

	# Create walls
	create_wall(Vector2(cam_pos.x, top - wall_thickness / 2), right - left, wall_thickness)   # Top
	create_wall(Vector2(cam_pos.x, bottom + wall_thickness / 2), right - left, wall_thickness) # Bottom
	create_wall(Vector2(left - wall_thickness / 2, cam_pos.y), wall_thickness, bottom - top)   # Left
	create_wall(Vector2(right + wall_thickness / 2, cam_pos.y), wall_thickness, bottom - top)  # Right


func create_wall(wall_pos: Vector2, width: float, height: float):
	var wall = StaticBody2D.new()
	wall.position = wall_pos

	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(width, height)
	shape.shape = rect

	wall.add_child(shape)
	add_child(wall)
