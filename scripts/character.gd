extends CharacterBody2D
class_name main_character



const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const THRESHOLD =5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var gravity =  980


var speed_up:float = 0.0
var is_push_up :bool =true

var speed_down :float = 0.0
var is_push_down :bool =true

var speed_right : float = 0.0
var is_push_right: bool = false

var speed_left: float = 0.0
var is_push_left:bool =true


var is_left : bool = false
var is_right : bool = false
var is_up : bool = false
var is_down : bool =true 

var is_on_force_up_down = false;
var is_on_force_left_right = false;








func _physics_process(delta):

	if is_on_force_up_down : 
		move_down( speed_calc(speed_down, delta, is_push_down ))
		move_up( speed_calc( speed_up , delta, is_push_up ))
	else : 
		add_gravity(delta)

	if is_on_force_left_right :
		move_right(speed_calc( speed_right, delta, is_push_right))
		move_left(speed_calc( speed_left, delta, is_push_left))
	
	if is_on_wall():
		$anim.play('hit_wall')

	move_and_slide()


func speed_calc(speed, delta, is_push = true ):

	var dir = 1 if is_push else -1
	return speed * SPEED * delta * dir	
func not_move(delta) :
	if (abs(speed_left - speed_right) <= THRESHOLD) :
		velocity.x = 0
	if(speed_down <= 0 and speed_up <= 0 ) :
		return

	if(abs(speed_down - speed_up) <= THRESHOLD)  :
		velocity.y = 0



func add_gravity(delta)  :
	velocity.y += gravity * delta;
func move_up(speed:float) :
	velocity += Vector2.UP * speed
func move_down(speed:float) :
	velocity += Vector2.DOWN* speed
func move_right(speed:float) :
	velocity += Vector2.RIGHT* speed
func move_left(speed:float) :
	velocity += Vector2.LEFT* speed

func push() :
	if is_down  :
		is_push_down = true
	if is_up  :
		is_push_up = true
	
	if is_left : 
		is_push_left = true
	if is_right :
		is_push_right = true
	
func pull() :
	if is_down  :
		is_push_down = false 
	if is_up  :
		is_push_up =  false
	
	if is_left : 
		is_push_left =  false
	
	if is_right :
		is_push_right =false 

func right() :
	is_right = true
	is_left = false
	is_up = false
	is_down = false
	speed_left = 0
func left() :
	is_left =true 
	is_right =false 
	is_up = false
	is_down = false
	speed_right = 0

func up() :
	is_up =true
	is_left =false
	is_right =false 
	is_down = false	
	speed_down = 0

func down() :
	is_down =true 
	is_up =false
	is_left =false
	is_right =false 
	speed_up = 0


func set_power(value:float):
	if is_down  :
		speed_down = value
	if is_up  :
		speed_up = value
	if is_left : 
		speed_left = value
	if is_right :
		speed_right = value