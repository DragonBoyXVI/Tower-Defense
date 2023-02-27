
var _time = global.timeslow

image_speed = _time

path_pos += ( (spd * slow) * _time )

var _pos = (path_pos/path_length)

x = ( path_get_x(path, _pos) + xoff )
y = ( path_get_y(path, _pos) + yoff )

if (_pos) >= 1 then {
	
	global.health -= dmg
	
	if (global.health <= 0) then game_end()
	
	instance_destroy()
	
}

if (x != xprevious or y != yprevious) then
	image_angle = point_direction(xprevious, yprevious, x, y)