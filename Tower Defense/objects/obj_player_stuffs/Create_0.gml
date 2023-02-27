state = STATES.IN_GAME_NOSELECT

if (instance_number(obj_player_stuffs) > 1) then {
	
	instance_destroy()
	exit
	
}

show_debug_message("im here")

#region inputs

grid_mouse_x = 0
grid_mouse_y = 0

mouse_left = false
mouse_right = false
mouse_middle = false

wheel_up = false
wheel_down = false

key_enter = false
key_backspace = false

key_up = false
key_down = false
key_right = false
key_left = false

keyboard_set_map(ord("W"), vk_up)
keyboard_set_map(ord("A"), vk_left)
keyboard_set_map(ord("S"), vk_down)
keyboard_set_map(ord("D"), vk_right)

key_one = false
key_two = false
key_three = false
key_four = false
key_five = false
key_six = false
key_seven = false
key_eight = false
key_nine = false
key_zero = false

#endregion inputs
#region grids 

chosen_x = -1
chosen_y = -1

chosen_tower = noone

pending_place = noone
pending_sprite = -1

#endregion grids 

#region camera

#macro SCREEN_WIDTH (1920)
#macro SCREEN_HEIGHT (1080)

#macro VIEW_CAM (view_camera[0])

display_set_gui_size(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

cur_lens_size = 2 //divide by these
target_lens_size = 2

wheel_change_speed = 0.2

move_speed = 16

function fun_resize_camera() {
	
	cur_lens_size = lerp(cur_lens_size, target_lens_size, 0.25)
	
	camera_set_view_size(VIEW_CAM, min( SCREEN_WIDTH/cur_lens_size, room_width ) , min( SCREEN_HEIGHT/cur_lens_size, room_height ))
	
}

#endregion camera

target_time = 1