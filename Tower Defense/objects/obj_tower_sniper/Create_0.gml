


event_inherited();

name = "Military Sniper"

gun_xscale = 1
gun_yscale = 1
gun_xoff = 0
gun_yoff = 0

body_speed = sprite_get_speed(spr_sniper_head)/room_speed
body_image = 0
body_limit = sprite_get_number(spr_sniper_head)

gunx = 0
guny = 0

skin_color = merge_color(make_colour_rgb(241.5, 185.3, 138.4), make_color_rgb(78.3, 40.4, 8.8), random(1))/*choose (
	make_colour_rgb(241.5, 185.3, 138.4),
	make_colour_rgb(190.5, 121.8, 64.4),
	make_colour_rgb(119.8, 55.4, 1.7),
	make_colour_rgb(78.3, 40.4, 8.8),
)*/

crit_mult = 1.5
aim_offset = 15

attack_speed = 0.2
bullet_speed = 20

range = 6

damage = 6

rotate_speed = 25
rotate_leeway = 3

fun_level_up = function() {
	
	damage += 0.2
	attack_speed += 0.005
	range += 0.01
	
	crit_mult += 0.01
	
	rotate_speed += 1.25
	
	aim_offset -= 0.4
	
}

fun_upgrade = function() {
	
	damage += 1.5
	range += 0.35
	
	crit_mult += 0.1
	
	//attack_speed -= 0.01
	//attack_bonus += 0.1
	
	//rotate_leeway += 0.5
	
}

fun_draw_range = function() {
	
	draw_circle(truex, truey, range_true, true)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction-rotate_leeway), truey+lengthdir_y(range_true, direction-rotate_leeway), c_black, c_black)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction+rotate_leeway), truey+lengthdir_y(range_true, direction+rotate_leeway), c_black, c_black)
	
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction+aim_offset), truey+lengthdir_y(range_true, direction+aim_offset), c_red, c_red)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction-aim_offset), truey+lengthdir_y(range_true, direction-aim_offset), c_red, c_red)
	
	if target then with target draw_sprite_stretched_ext(spr_pix_hollow, 0, x-16, y-16, 32, 32, c_white, 1)
	//if saved_target then with saved_target draw_sprite_stretched_ext(spr_pix_hollow, 0, bbox_left, bbox_top, bbox_right-bbox_left, bbox_bottom-bbox_top, c_red, 1)
	
}
