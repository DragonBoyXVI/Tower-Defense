
var _time = global.timeslow

var _dir = direction-90

gunx = truex + lengthdir_x(16+gun_xoff, direction)
guny = truey + lengthdir_y(16+gun_yoff, direction)

draw_sprite(spr_sniper_boxes, 0, truex, truey)
draw_sprite_ext(spr_sniper_gun, 0, gunx, guny, gun_xscale, gun_yscale, direction, c_white, 1)
draw_sprite_ext(spr_sniper_skin, body_image, truex, truey, 1, 1, _dir, skin_color, 1)
draw_sprite_ext(spr_sniper_head, body_image, truex, truey, 1, 1, _dir, c_white, 1)

//draw_sprite(spr_pix, 0, truex, truey)
//draw_sprite(spr_pix, 0, gunx, guny)

draw_text(x, y+32, attack_cooldown)

body_image += body_speed * _time
body_image = ( body_image >= body_limit ? 0 : body_image )

gun_xscale -= (gun_xscale != 1 ? sign(gun_xscale-1)/10 : 0)
gun_yscale -= (gun_yscale != 1 ? sign(gun_yscale-1)/10 : 0)

gun_xoff -= (gun_xoff != 0 ? sign(gun_xoff) : 0)
gun_yoff -= (gun_yoff != 0 ? sign(gun_yoff) : 0)