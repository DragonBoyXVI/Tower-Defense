global.coins = infinity//255
global.health = 20

global.timeslow = 1

global.default_target = 0

global.startx = -1
global.starty = -1
global.endx = -1
global.endy = -1

global.game_curpath_basic = mp_grid_create(0, 0, room_width/64, room_height/64, 64, 64)
global.game_curpath_basic_actual = path_add()
global.path_basic_length = -1

global.tower_grid = ds_grid_create(1, 1)
global.enemy_grid = ds_grid_create(1, 1)

#region gameshit

#macro GRIDSIZE_WIDTH (64)
#macro GRIDSIZE_HEIGHT (64)
#macro SPRITESCALE (2)

#endregion gameshit
enum STATES {
	
	MENU_MAIN,
	
	IN_GAME_NOSELECT,
	IN_GAME_TOWER_MENU,
	IN_GAME_PLACE_TOWER_MENU,
	
}

enum FIND {
	
	FIRST,
	LAST,
	NEAR,
	FAR,
	STRONG,
	WEAK,
	
	//STRONG_AGAINST,
	
	RANDOM,
	
}

enum HEROES {
	
	DRAC,
	KATE_FEVIR,
	MUD,
	FEVIR,
	JAB,
	
}

function fun_setup_relivant_grids() {
	
	var _wgrid_center = GRIDSIZE_WIDTH/2
	var _hgrid_center = GRIDSIZE_HEIGHT/2
	
	#region enemy grid
	
	mp_grid_destroy(global.game_curpath_basic)
	
	global.game_curpath_basic = mp_grid_create(0, 0, room_width/GRIDSIZE_WIDTH, room_height/GRIDSIZE_HEIGHT, GRIDSIZE_WIDTH, GRIDSIZE_HEIGHT)
	path_delete(global.game_curpath_basic_actual)
	
	var _tilelayer = layer_get_id("Tiles_1")
	var _tileelem = layer_tilemap_get_id(_tilelayer)
	
	var _thistile = -1
	var i = 0
	var j = 0
	repeat(room_width/GRIDSIZE_WIDTH) {
		
		j = 0
		
		repeat(room_height/GRIDSIZE_HEIGHT) {
			
			_thistile = tilemap_get_at_pixel(_tileelem, _wgrid_center+(i*GRIDSIZE_WIDTH), _hgrid_center+(j*GRIDSIZE_HEIGHT))
			
			if (_thistile == 2) then {
				
				mp_grid_add_cell(global.game_curpath_basic, i, j)
				
			}
			
			j++
			
		}
		
		i++
		
	}
	
	global.game_curpath_basic_actual = path_add()
	mp_grid_path(global.game_curpath_basic, global.game_curpath_basic_actual, global.startx, global.stary, global.endx, global.endy, false)
	global.path_basic_length = path_get_length(global.game_curpath_basic_actual)
	
	#endregion enemy grid
	#region tower grid
	
	ds_grid_resize(global.tower_grid, room_width/GRIDSIZE_WIDTH, room_height/GRIDSIZE_HEIGHT)
	ds_grid_clear(global.tower_grid, noone)
	
	#endregion tower grid
	
}

function fun_tower_get_target(_range = range_true) { //run inside a tower
	
	if !instance_exists(obj_enemy_parent) then exit
	
	//var _range = range_true
	
	var _targets = ds_list_create()
	
	var _hit = collision_circle_list(truex, truey, _range, obj_enemy_parent, false, true, _targets, true) //ordered by distance to tower
	
	if (_hit > 0) then {
		
		var i = 0
		var _this = noone
		repeat(_hit) { //remove out of range targets
			
			_this = ds_list_find_value(_targets, i)
			
			if (_this and point_distance(truex, truey, _this.x, _this.y) > range_true) then {
				ds_list_delete(_targets, i)
				continue
			}
			
			i++
			
		}
		
		switch(find) {
			
			case FIND.FIRST:
			#region first
			
			i = 0
			var _closest = noone
			var _close_pos = -1
			var _this = noone
			var _this_pos = -1
			
			repeat(ds_list_size(_targets)) {
				
				_this = ds_list_find_value(_targets, i)
				_this_pos = _this.path_pos
				
				_closest = (_close_pos > _this_pos ? _closest : _this)
				_close_pos = (_close_pos > _this_pos ? _close_pos : _this_pos)
				
				i++
				
			}
			
			target = _closest
			
			#endregion first
			break
				
			case FIND.LAST:
			#region last
			
			i = 0
			var _furthest = noone
			var _furth_pos = infinity
			var _this = noone
			var _this_pos = infinity
			
			repeat(ds_list_size(_targets)) {
				
				_this = ds_list_find_value(_targets, i)
				_this_pos = _this.path_pos
				
				_furthest = (_furth_pos < _this_pos ? _furthest : _this)
				_furth_pos = (_furth_pos < _this_pos ? _furth_pos : _this_pos)
				
				i++
				
			}
			
			target = _furthest
			
			#endregion first
			break
			
			case FIND.NEAR:
			#region nearest
			
			target = ds_list_find_value(_targets, 0) //( _hit > 0 ? instance_nearest(truex, truey, obj_enemy_parent) : noone )
			
			#endregion nearest
			break
			
			case FIND.FAR:
			#region furthest
			
			target = ds_list_find_value(_targets, ds_list_size(_targets)-1)
			
			#endregion furthest
			break
			
			case FIND.STRONG:
			#region strong
			
			i = 0
			var _this = noone, _this_hp = -1, _healthy = noone, _healthy_hp = 0
			repeat(ds_list_size(_targets)) {
				
				_this = ds_list_find_value(_targets, i)
				_this_hp = _this.hp
				
				_healthy = ( _healthy_hp < _this_hp ? _this : _healthy )
				_healthy_hp = ( _healthy_hp < _this_hp ? _this_hp : _healthy_hp )
				
				i++
				
			}
			
			target = _healthy
			
			#endregion strong
			break
			
			case FIND.WEAK:
			#region weak
			
			i = 0
			var _this = noone, _this_hp = infinity, _healthy = noone, _healthy_hp = infinity
			repeat(ds_list_size(_targets)) {
				
				_this = ds_list_find_value(_targets, i)
				_this_hp = _this.hp
				
				_healthy = ( _healthy_hp > _this_hp ? _this : _healthy )
				_healthy_hp = ( _healthy_hp > _this_hp ? _this_hp : _healthy_hp )
				
				i++
				
			}
			
			target = _healthy
			
			#endregion weak
			break
			
			case FIND.RANDOM:
			#region random
			
			target = ds_list_find_value(_targets, irandom(ds_list_size(_targets)-1))
			
			#endregion random
			break
			
		}
	
	}
	
	ds_list_destroy(_targets)
	
	if (target != noone) then {
		state = 1
		//event_perform(ev_step, ev_step_normal)
	}
	
	return _hit
	
}

function fun_rotate_to_point(_x, _y, _tx, _ty, _spd) {
	
	var _time = global.timeslow
	
	var _targ_dir = point_direction(_x, _y, _tx, _ty)
	var _ang_diff = angle_difference(direction, _targ_dir)
	
	direction -= ( min(abs(_ang_diff), (_spd/room_speed) * _time) * sign(_ang_diff) )
	
	return _targ_dir
	
}

function fun_xp(_level) {
	
	return power(2, _level)
	
}
	
function fun_give_exp(_who, _amt) {
	
	if (not _who or not instance_exists(_who)) then exit
	
	with _who {
		
		alarm[0] = 1
		
		xp += _amt*xp_bonus
		
		if (xp >= xp_to_level and level < level_max) then {
			
			level++
			xp_to_level = fun_xp(level+1)
			
			fun_level_up()
			
			#region recalc true vals
			
			range_true = range * ( (GRIDSIZE_HEIGHT+GRIDSIZE_WIDTH) / 2)
			
			#endregion recalc true vals
			
		}
		
	}
	
}

function fun_copy_multis() {
	
	dmg_mod_basic = other.dmg_mod_basic
	dmg_mod_strong = other.dmg_mod_strong
	
}

function fun_attack_cooldown(_atks_per_sec) {
	
	return max( (60/_atks_per_sec)/2, 1, global.timeslow )
	
}

function fun_other_bullet_speed() {
	
	return (other.bullet_speed * ((GRIDSIZE_HEIGHT+GRIDSIZE_WIDTH)/2))
	
}

function fun_string_reverse(_txt) {
	
	var _new = ""
	
	var i = 0, _length = string_length(_txt)
	repeat(_length) {
		
		_new = string_concat(_new, string_char_at(_txt, _length-i))
		
		i++
		
	}
	
	return _new
	
}

//instance_create_depth(0, 0, 0, obj_player_stuffs)

#region fonts and colours

var _mapstring = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()`-=[];',./\\~_+{}:\"<>?|αβγδεζηθικλμνξπρστυφχψΩ"

_mapstring = fun_string_reverse(_mapstring)

global.drac_font = font_add_sprite_ext(spr_drac_font, _mapstring, true, 2)
#macro FNT_DRAC (global.drac_font)

#endregion fonts and colours

