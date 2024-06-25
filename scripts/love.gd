extends StaticBody2D

@export var length:float = 80.0;

#dir left = 2 and right =3
var left:int =2 #direction left
var right: int =3 #direction right

@onready var blue = $blue
@onready var red = $red
@onready var ditection = $ditection
@onready var anim = $anim

var characters =   []
# Called when the node enters the scene tree for the first time.
func _ready():

	blue.dir  = left
	blue.length = length
	blue.set_direction(left)
	blue.is_push = false

	red.dir  =right 
	red.length = length
	red.set_direction(right)
	red.is_push =true 

	ditection.connect("body_entered", on_body_entered)
	ditection.connect("body_exited", on_body_exited)





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if characters.size() >=2 :
		anim.play("over")
		set_process(false)



func on_body_entered(body:Node2D) :
	if body is main_character:
		for i in range(characters.size()) :
			if characters[i] == body :
				return
		characters.push_back(body)
		body.shocking()
		body.over()

func on_body_exited(body:Node2D) :
	if body is main_character:
		var remove_index = -1
		for i in range(characters.size()) :
			if characters[i] == body : 
				remove_index = i
		
		if remove_index >=0 :
			characters.remove_at(remove_index)
		body.sleeping()
		body.reset()

