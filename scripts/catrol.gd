extends Node2D

@export var speed :float = 50.0

@onready var body = $body
@onready var placer = $placer
@onready var bottom = $placer/bottom
@onready var anim = $anim
@onready var rope = $rope


var active = false
var state = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	body.connect("input_event", input_event)
	placer.connect("body_entered", body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active :
		return

	placer.position.y  += (delta * speed * state) 
	rope.points[1].y += (delta * speed * state) 

func input_event(_node:Viewport, event: InputEvent , _shape:int) :
	if event is InputEventMouseButton :
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT :
			state *=-1
			active = true
			if(state >=0 ) :
				anim.play('roller')
			else :
				anim.play_backwards("roller")

func body_entered(body:Node2D) :
	if body.is_in_group("ignore") :
		return
	active = false
	anim.pause()
	