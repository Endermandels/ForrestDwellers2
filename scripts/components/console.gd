extends Control
class_name Console

@export var history_limit: int = 100 ## Number of labels before start to delete new labels
@export var scroll_box: ScrollContainer
@export var chat_box: VBoxContainer
@export var line_edit: LineEdit

func _ready() -> void:
	hide()
	line_edit.text_submitted.connect(_on_line_edit_text_submitted)
	line_edit.text_changed.connect(_on_line_edit_text_changed)

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.contains("`"):
		toggle()

func _on_line_edit_text_submitted(new_text: String) -> void:
	add_text_to_chat_box(new_text)
	line_edit.text = ""

## Toggle showing or hiding the console
func toggle() -> void:
	if not visible:
		line_edit.text = ""
		line_edit.grab_focus()
		show()
	else:
		hide()

## Add a Label to the Chat Box
func add_text_to_chat_box(text: String) -> void:
	var label: Label = Label.new()

	label.text = text
	chat_box.add_child(label)
	
	if chat_box.get_child_count() > history_limit:
		chat_box.get_child(0).queue_free()

	await get_tree().process_frame # Need to wait before child is registered
	scroll_box.ensure_control_visible(label)
