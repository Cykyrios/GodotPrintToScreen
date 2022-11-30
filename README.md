# Godot PrintToScreen
Utility GDScript to print text directly on screen instead of terminal/output panel

This can be useful for transient info you want to print, but do not want to print to the output panel/terminal.

The example below shows random text being displayed.

![PrintToScreen](https://user-images.githubusercontent.com/53737317/204773942-20709d43-210d-4ce2-9ecd-b74773e0c5c4.gif)

## Usage
Add the script as an autoload to your project, then call `PrintToScreen.print_to_screen()` from anywhere in your code.

Some options are available by changing the constants at the beginning of the script. You can also customize the fade out animation in `animate_label()`.
You can search `print_to_screen` in the documentation for details.
