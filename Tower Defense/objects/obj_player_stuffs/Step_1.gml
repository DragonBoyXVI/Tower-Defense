
#region inputs

grid_mouse_x = floor(mouse_x/GRIDSIZE_WIDTH)
grid_mouse_y = floor(mouse_y/GRIDSIZE_HEIGHT)

mouse_left = mouse_check_button_pressed(mb_left)
mouse_right = mouse_check_button_pressed(mb_right)
mouse_middle = mouse_check_button_pressed(mb_middle)

wheel_up = mouse_wheel_up()
wheel_down = mouse_wheel_down()

key_enter = keyboard_check_pressed(vk_enter)
key_backspace = keyboard_check_pressed(vk_backspace)

key_up = keyboard_check(vk_up)
key_down = keyboard_check(vk_down)
key_right = keyboard_check(vk_right)
key_left = keyboard_check(vk_left)

key_one = keyboard_check_pressed(ord("1"))
key_two = keyboard_check_pressed(ord("2"))
key_three = keyboard_check_pressed(ord("3"))
key_four = keyboard_check_pressed(ord("4"))
key_five = keyboard_check_pressed(ord("5"))
key_six = keyboard_check_pressed(ord("6"))
key_seven = keyboard_check_pressed(ord("7"))
key_eight = keyboard_check_pressed(ord("8"))
key_nine = keyboard_check_pressed(ord("9"))
key_zero = keyboard_check_pressed(ord("0"))

#endregion inputs
