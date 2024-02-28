extends KinematicBody2D

export var speed: int = 400
export var GRAVITY: int = 1200
export var jump_speed: int = -500

const UP = Vector2(0,-1)

const idle_texture: String = "res://assets/kenney_platformercharacters/PNG/Soldier/Poses/soldier_idle.png"
const crouch_texture: String = "res://assets/kenney_platformercharacters/PNG/Soldier/Poses/soldier_duck.png"
const walk_texture: String = "res://assets/kenney_platformercharacters/PNG/Soldier/Poses/soldier_walk1.png"
const dash_texture: String = "res://assets/kenney_platformercharacters/PNG/Soldier/Poses/soldier_slide.png"
const jump: String = "res://assets/kenney_platformercharacters/PNG/Soldier/Poses/soldier_jump.png"

var jump_count: int = 0
const max_jump = 2

var can_dash: bool = false

var velocity = Vector2()

func _ready():
	pass

func get_input():
	velocity.x = 0
	
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_pressed('right'):
		$Sprite.texture = load(walk_texture)
		velocity.x += speed

	if Input.is_action_just_released("right"):
		$Sprite.texture = load(idle_texture)

	if Input.is_action_pressed('left'):
		$Sprite.texture = load(walk_texture)
		velocity.x -= speed
		
	if Input.is_action_just_released('left'):
		$Sprite.texture = load(idle_texture)
	
	if jump_count == 1 and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		$Sprite.texture = load(jump)
		jump_count = 0

	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		$Sprite.texture = load(jump)
		jump_count += 1

	if Input.is_action_just_released("up"):
		$Sprite.texture = load(idle_texture)
	
	if Input.is_action_pressed('dash') and velocity.x > 0:
		$Sprite.texture = load(dash_texture)
		velocity.x += 400

	if Input.is_action_pressed('dash') and velocity.x < 0:
		$Sprite.texture = load(dash_texture)
		velocity.x -= 400

	if Input.is_action_just_released("dash"):
		$Sprite.texture = load(idle_texture)
	
	if Input.is_action_pressed('down'):
		velocity.y = 500
		$Sprite.texture = load(crouch_texture)

	if Input.is_action_just_released("down"):
		$Sprite.texture = load(idle_texture)

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
