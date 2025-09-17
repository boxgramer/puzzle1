extends Node2D


@onready var label = $Label;
@onready var love = $love

func _ready() -> void:
	love.connect("on_hug", Callable(self, "_on_hug"))
	pass

func _on_hug():
	label.text = "Thanks for bringing them together. \n Game over"
