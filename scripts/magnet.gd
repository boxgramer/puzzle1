extends StaticBody2D


@export_enum("up", "down", 'left', 'right') var dir : int = 1;
@export var length:float = 70.0;
@export var is_push:bool = true;
@export var is_dead:bool = false;


@onready var anim: AnimatedSprite2D = $anim
@onready var shape :CollisionShape2D= $shape
@onready var  cast:RayCast2D = $cast 
@onready var  cast2:RayCast2D = $cast2
@onready var  cast3:RayCast2D = $cast3 


var state:int = 0;



var size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	size =  shape.shape.size/2 - Vector2(10, 10)
	setup()

func setup () :
	set_rotation_anim(dir)
	anim_state(state)

	cast.dir  = dir
	cast.length = length
	cast.set_direction(dir)



	cast2.dir  = dir
	cast2.length = length
	cast2.set_direction(dir)



	cast3.dir  = dir
	cast3.length = length
	cast3.set_direction(dir)




	if dir == 2 || dir == 3 :
		cast2.position.y -= size.y
		cast3.position.y += size.y

	elif dir == 1 || dir == 0 :
		cast2.position.x -= size.x
		cast3.position.x += size.x


func set_rotation_anim( dir :int) :
	match (dir) :
		0 : 
			anim.rotation_degrees =0 
		1 : 
			anim.rotation_degrees = 180
		2 : 
			anim.rotation_degrees = 270
		3 : 
			anim.rotation_degrees = 90

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton :
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT :
			change_state()
			anim_state(state)
func change_state() :
	state += 1;
	state = state % 3;

func anim_state(st : int) :
	match  (st) :
		0 : 
			anim.play("dead")
			is_dead = true
		1 : 
			anim.play("red")
			is_dead = false
			is_push = true
		2 : 
			anim.play("blue")
			is_dead = false
			is_push = false

	update_status_push_and_dead()
		
func update_status_push_and_dead() :
	cast.is_push = is_push
	cast.is_dead = is_dead
	cast2.is_push = is_push
	cast2.is_dead = is_dead
	cast3.is_push = is_push
	cast3.is_dead = is_dead

