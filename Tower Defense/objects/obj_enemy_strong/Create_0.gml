event_inherited()

var _scale = obj_portal.cur_scale

path = (obj_portal.path_basic == -1 ? obj_portal.path_all : obj_portal.path_basic)

coin_val = max( round(_scale*0.75), 1 )
max_hp = 4 * _scale
hp = max_hp

spd = 0.85

path_length = path_get_length(path)