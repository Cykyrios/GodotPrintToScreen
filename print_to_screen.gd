extends CanvasLayer
## On-screen print utility
##
## Allows printing temporary text strings on screen.
## Make this script an autoload and call
## [method print_to_screen] from
## anywhere in your code.

## Maximum number of prints displaying simultaneously.
## Additional prints will replace already displayed text as needed.
const POOL_SIZE := 20
## Position of the top print relative to the top left corner.
const CORNER_OFFSET := Vector2(100, 50)
## Display duration of each print before fade animation.
const DURATION := 3


var _vbox: VBoxContainer = null
var _labels: Array[Label] = []
var _tweens: Array[Tween] = []
var _idx := 0


func _ready() -> void:
	layer = 99

	_vbox = VBoxContainer.new()
	_vbox.offset_top = CORNER_OFFSET.x
	_vbox.offset_left = CORNER_OFFSET.y
	add_child(_vbox)

	var label_settings := LabelSettings.new()
	label_settings.font_color = Color.WHITE
	label_settings.outline_color = Color.BLACK
	label_settings.outline_size = 3

	for i in POOL_SIZE:
		var label := Label.new()
		label.modulate.a = 0
		label.label_settings = label_settings
		_vbox.add_child(label)
		_labels.append(label)
		var tween := create_tween()
		tween.kill()
		_tweens.append(tween)


## Describes the animation to play after timeout.
## Modify as desired to customize animation.[br]
## Default animation decreases the label's alpha linearly within one second.
func animate_label(label: Label, tween: Tween) -> void:
	tween.tween_property(label, "modulate:a", 0, 1)


## Call this function to actually print text on screen.
func print_to_screen(text: String) -> void:
	var label := _labels[_idx]
	var tween := _tweens[_idx]
	_vbox.move_child(label, 0)
	tween.kill()
	label.text = text
	label.modulate = Color(1, 1, 1, 1)
	tween = create_tween()
	tween.tween_interval(DURATION)
	animate_label(label, tween)
	_tweens[_idx] = tween
	_idx = wrapi(_idx + 1, 0, _labels.size())
