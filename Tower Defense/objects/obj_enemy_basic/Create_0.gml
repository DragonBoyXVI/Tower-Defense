event_inherited()

var _scale = obj_portal.cur_scale

path = (obj_portal.path_basic == -1 ? obj_portal.path_all : obj_portal.path_basic)

coin_val = max( round(_scale*0.5), 1 )
max_hp = 2 * _scale
hp = max_hp

spd = 1.5

path_length = path_get_length(path)