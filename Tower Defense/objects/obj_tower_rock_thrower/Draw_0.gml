
draw_sprite(spr_rock_thrower_pile, 0, truex, truey)
draw_sprite_ext(spr_rock_thrower_head, body_image, truex, truey, 1, 1, direction-90, c_white, 1)

if (sprite_index != -1) then {
	
	draw_sprite_ext(sprite_index, image_index, truex, truey, 1, 1, direction-90, c_white, 1)
	
}

body_image += body_speed * global.timeslow
body_image = ( body_image >= body_limit ? 0 : body_image )

draw_text(truex, truey, attack_cooldown)