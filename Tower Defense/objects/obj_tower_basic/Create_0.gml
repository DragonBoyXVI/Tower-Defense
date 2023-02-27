grid_offx = GRIDSIZE_WIDTH/2
grid_offy = GRIDSIZE_HEIGHT/2

alarm[0] = 1

truex = x + grid_offx
truey = y + grid_offy

state = 0
find = global.default_target//FIND.FIRST

target = noone

kills = 0

//direction = 270//90

attack_cooldown = 0

#region all towers have these stats, but not all are used

damage = 1
range = 3.675 //in tiles
range_true = range * ( (GRIDSIZE_HEIGHT+GRIDSIZE_WIDTH) / 2)

bullet_speed = 0.05 //in tiles
bullet_rotation = 60 //degrees per second
bullet_peirce = 0
bullet_peirce_degrade = 100
bullet_peirce_damage_degrade = 0.25

rotate_speed = 75
rotate_leeway = 10

explosion_per = 0.5
explosion_range = 0.5 //in tiles
explosion_happens = false

attack_speed = 1.25 //attacks per second

#endregion all towers have these stats, but not all are used

level = 0
level_max = 5
xp = 0
xp_to_level = fun_xp(level+1)

xp_bonus = 1

fun_level_up = function() {
	
	range += 0.01
	attack_speed += 0.05
	damage += 0.25
	rotate_speed += 1.1
	bullet_speed += 0.05
	
	bullet_peirce += 1
	
}

upgrade = 0
upgrade_max = 5
upgrade_cost = 15

fun_upgrade = function() {
	
	range += 0.25
	rotate_speed += 2.265
	bullet_speed += 0.15
	
	bullet_peirce += 5
	bullet_peirce_degrade -= 4
	
}

fun_draw_menu = function() {
	
	draw_text(500, 500, "menu, right click to exit")
	draw_circle(truex, truey, range_true, true)
	
	if target != noone then
		draw_sprite_ext(spr_pix_hollow, 0, target.x, target.y, 6, 6, 0, c_white, 1)
	
}

dmg_mod_basic = 1.5
dmg_mod_strong = 1