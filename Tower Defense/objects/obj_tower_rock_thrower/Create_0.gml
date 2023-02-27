

event_inherited()

body_speed = sprite_get_speed(spr_rock_thrower_head)/room_speed
body_image = 0
body_limit = sprite_get_number(spr_rock_thrower_head)

saved_target = noone

sprite_index = -1

bullet_rotation = 180 //they are really good at curveballs

attack_speed = 0.85

//find = FIND.WEAK //choose(FIND.NEAR, FIND.FAR)

level_max = 10

upgrade_max = 3
upgrade_cost = 25

name = "Kobold Rock Thrower"

bullet_peirce = 0
bullet_peirce_damage_degrade = 0.8
bullet_peirce_degrade = 100

fun_level_up = function() {
	
	damage += 0.125
	range += 0.01
	attack_speed += 0.025
	
	rotate_speed += 0.75
	bullet_rotation += 5
	
	bullet_peirce_degrade -= 1
	
	
}

fun_upgrade = function() {
	
	damage += 1
	range += 0.25
	
	rotate_leeway += 2
	
	bullet_peirce += 10
	bullet_peirce_damage_degrade += 0.01
	
	bullet_rotation += 5
	
}

fun_draw_range = function() {
	
	draw_circle(truex, truey, range_true, true)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction-rotate_leeway), truey+lengthdir_y(range_true, direction-rotate_leeway), c_black, c_black)
	draw_line_color(truex, truey, truex+lengthdir_x(range_true, direction+rotate_leeway), truey+lengthdir_y(range_true, direction+rotate_leeway), c_black, c_black)
	
	if target then with target draw_sprite_stretched_ext(spr_pix_hollow, 0, x-16, y-16, 32, 32, c_white, 1)
	if saved_target then with saved_target draw_sprite_stretched_ext(spr_pix_hollow, 0, x-16, y-16, 32, 32, c_red, 1)
	
}

/*
fun_draw_menu = function() {
	
}