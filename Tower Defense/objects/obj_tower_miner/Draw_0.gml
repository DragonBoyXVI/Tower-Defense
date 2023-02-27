
draw_sprite_ext(spr_miner_head, body_image, truex, truey, 1, 1, direction-90, c_white, 1)
draw_sprite_ext(sprite_index, image_index, truex, truey, 1, 1, direction-90, c_white, 1)

draw_text(x, y+32, attack_cooldown)

body_image += body_speed * global.timeslow
body_image = ( body_image >= body_limit ? 0 : body_image )