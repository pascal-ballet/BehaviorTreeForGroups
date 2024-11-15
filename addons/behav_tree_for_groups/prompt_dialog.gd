## PromptDialog class asking for the name of a new agent

extends Window

class_name PromptDialog

var input_field: LineEdit

signal prompt_confirmed(input_text: String)
signal prompt_canceled

func _init():
	pass

func _ready() -> void:
	# Vertical Box Container to put the Line Edit
	# and the OK and CANCEL buttons
	var vbox:VBoxContainer = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	# Set light grey background color
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.9, 0.0, 0.9, 1.0)  # Light grey color
	vbox.add_theme_stylebox_override("panel", style)
	# Add a MarginContainer for better spacing
	var margin = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_right", 16)
	vbox.add_child(margin)
	
	# LineEdit creation to enter the 2d agent name
	input_field = LineEdit.new()
	input_field.alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
	input_field.expand_to_text_length = true
	input_field.placeholder_text = "agent_name"
	vbox.add_child(input_field)

	# HBox creation to put Buttons OK and CANCEL
	var hbox:HBoxContainer = HBoxContainer.new()
	hbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	hbox.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	hbox.add_theme_constant_override("separation", 10)  # Space between buttons
	vbox.add_child(hbox)

	# OK button creation
	var ok_button = Button.new()
	ok_button.text = "OK"
	ok_button.pressed.connect(self._on_ok_button_pressed)
	ok_button.size_flags_horizontal = Control.SIZE_FILL
	set_button_style(ok_button, Color(0.0, 0.6, 0.0, 1.0))
	hbox.add_child(ok_button)

	# CANCEL button creation
	var cancel_button = Button.new()
	cancel_button.text = "CANCEL"
	cancel_button.pressed.connect(self._on_cancel_button_pressed)
	set_button_style(cancel_button, Color(0.6, 0.0, 0.0, 1.0))
	hbox.add_child(cancel_button)

	# Add the VBox to the modal prompt Window
	add_child(vbox)

# Set the style of a given button
func set_button_style(button:Button, text_color:Color):
	# Create button styles
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.6, 0.6, 0.6, 1.0)
	normal_style.corner_radius_top_left = 4
	normal_style.corner_radius_top_right = 4
	normal_style.corner_radius_bottom_left = 4
	normal_style.corner_radius_bottom_right = 4

	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.8, 0.8, 0.8, 1.0)
	hover_style.corner_radius_top_left = 4
	hover_style.corner_radius_top_right = 4
	hover_style.corner_radius_bottom_left = 4
	hover_style.corner_radius_bottom_right = 4

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.85, 0.85, 0.85, 1.0)
	pressed_style.corner_radius_top_left = 4
	pressed_style.corner_radius_top_right = 4
	pressed_style.corner_radius_bottom_left = 4
	pressed_style.corner_radius_bottom_right = 4
	
	# Apply styles to button
	button.add_theme_stylebox_override("normal", normal_style)
	button.add_theme_stylebox_override("hover", hover_style)
	button.add_theme_stylebox_override("pressed", pressed_style)
	
	# Add padding to button
	button.custom_minimum_size.x = 100
	button.custom_minimum_size.y = 30
	
	# Set button text color
	button.add_theme_color_override("font_color", Color.WHITE)
	button.add_theme_color_override("font_hover_color", text_color)

# Events from the buttons
func _on_ok_button_pressed() -> void:
	emit_signal("prompt_confirmed", input_field.text)
	hide()
	print("PromptDialog : _on_ok_button_pressed")
	
func _on_cancel_button_pressed() -> void:
	emit_signal("prompt_canceled", "")
	hide()
	print("PromptDialog : _on_cancel_button_pressed")
