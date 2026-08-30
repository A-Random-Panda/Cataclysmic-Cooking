extends Node

var vistor_time: float = 0.0
var vistor_here: bool = false
var fire_list: Array[Vector2] = []
var timer: float = 0.0
var fire_sabo: bool = false
var in_sabo: bool = false
var timer2: float = 0.0
var insta_fire: int = 0
var workers: int = 0
var sabotimer: float = 0.0
var audio: AudioStreamPlayer
var fire_sound: AudioStream = preload("res://assets/sounds/vents_on_fire.mp3")
var x: bool = true



func play_sound(sound: AudioStream) -> void:
	audio.stream = sound
	audio.play()

func _ready() -> void:
	audio = AudioStreamPlayer.new()
	add_child(audio)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	sabotimer += delta
	if fire_sabo:
		timer += delta
	if not in_sabo:
		timer2 += delta
		if timer2 > 8:
			insta_fire += 1
			timer2 = 0
	if sabotimer > 20 and not x:
		x = true
		play_sound(fire_sound)
		fire_sabo = true
		
			

	if not vistor_here:
		Hyvariables.vistor_time += delta
