/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

body_speed = sprite_get_speed(spr_miner_head)/room_speed
body_image = 0
body_limit = sprite_get_number(spr_miner_head)

name = "Kobold Miner"

damage = 4
rotate_speed = 100
rotate_leeway = 5

range = 1.65

attack_speed = 0.5
attack_bonus = 1.25

dmg_mod_basic = 1
dmg_mod_strong = 2

saved_target = noone

level_max = 10

upgrade_max = 3
upgrade_cost = 45

fun_level_up = function() {
	
	damage += 0.2
	attack_speed += 0.005
	
	rotate_speed += 1.25
	
	attack_bonus += 0.025
	
}

fun_upgrade = function() {
	
	damage += 1.5
	range += 0.01
	
	attack_speed -= 0.05
	attack_bonus += 0.1
	
	rotate_leeway += 0.5
	
}

fun_draw_range = function() {
	
	draw_circle(truex, truey, range_true, true)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction-rotate_leeway), truey+lengthdir_y(range_true, direction-rotate_leeway), c_black, c_black)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction+rotate_leeway), truey+lengthdir_y(range_true, direction+rotate_leeway), c_black, c_black)
	
	if target then with target draw_sprite_stretched_ext(spr_pix_hollow, 0, x-16, y-16, 32, 32, c_white, 1)
	//if saved_target then with saved_target draw_sprite_stretched_ext(spr_pix_hollow, 0, bbox_left, bbox_top, bbox_right-bbox_left, bbox_bottom-bbox_top, c_red, 1)
	
}
