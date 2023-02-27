
var _time = global.timeslow

image_speed = _time

if (target and target != obj_enemy_parent and instance_exists(target)) then {
	
	/*
	var _targx = target.x, _targy = target.y
	
	var _targ_dir = point_direction(x, y, _targx, _targy)
	var _ang_diff = angle_difference(direction, _targ_dir)
	
	direction -= ( min(abs(_ang_diff), (rotate_speed/room_speed) * _time) * sign(_ang_diff) )
	*/
	
	fun_rotate_to_point(x, y, target.x, target.y, rotate_speed)
	
} else if (is_homing) then {
	
	target = instance_nearest(x, y, obj_enemy_parent)
	can_hit = target
	
	} else {
	
	can_hit = obj_enemy_parent
	target = noone
	
}

x += ( lengthdir_x(spd, direction) * _time )
y += ( lengthdir_y(spd, direction) * _time )

ds_list_clear(collision_list)
var _hit = collision_line_list(xprevious, yprevious, x, y, obj_enemy_parent, false, true, collision_list, true)

#region old
/*

var i = 0, _this = noone, _thisdied = false
repeat(_hit) {
	
	_this = ds_list_find_value(collision_list, i)
	
	if not _this then continue
	
	_thisdied = false
	
	with _this {
		
		hp -= other.dmg
		
		if (hp <= 0) then {
			
			global.coins += coin_val
			
			_thisdied = true
			
			instance_destroy()
			
		}
		
	}
	
	fun_give_exp(owner, obj_portal.cur_scale * ( _thisdied ? 1.1 : 0.1 ))
	
	if (random(99) > chance_peirce) then {//fail
		
		instance_destroy()
		
		break
		
	} else {
		
		dmg *= damage_degrade
		
		chance_peirce -= chance_peirce_degrade
		
	}
	
	i++
	
}

*/
#endregion old

#region hit shit
/*

var _who_is_it = noone, _signx = 0, _signy = 0, _who_died = false,
while(_xspd != 0 and _yspd != 0) {
	
	_who_died = false
	
	_who_is_it = instance_place(x, y, can_hit)
	
	if (_who_is_it == can_hit) then {
		
		with _who_is_it {
			
			hp -= other.dmg
			
			if (hp <= 0) then {
				
				_who_died = true
				
				global.coins += coin_val
				
				instance_destroy()
				
			}
			
			
		}
		
		fun_give_exp(owner, obj_portal.cur_scale * ( _who_died ? 0.55 : 0.05 ))
		
		if (_who_died) then {
			
			can_hit = obj_enemy_parent
			
		}
		
		if (random(99) > chance_peirce) then {//fail
			
			instance_destroy()
			break
			
		} else {
			
			chance_peirce -= chance_peirce_degrade
			dmg *= damage_degrade
			can_hit = obj_enemy_parent
			target = noone
			
		}
		
	}
	
	_signx = sign(_xspd)
	x += _signx
	_xspd -= _signx
	
	_signy = sign(_yspd)
	y += _signy
	_yspd -= _signy
	
}

*/
#endregion hit shit

#region lets try that again

var _this = noone, _this_died = false, i = 0
while(i < _hit) {
	
	_this_died = false
	
	_this = ds_list_find_value(collision_list, i)
	
	if (_this and instance_exists(_this)) then {//check if this exists
		
		if ( (target == noone) or (target == _this) ) then {
			
			if (sprite_index == spr_rock_thrower_rocks) then effect_create_above(ef_cloud, _this.x, _this.y, random(0.05), c_gray)
			
			with _this {
				
				var _dam = other.dmg * (other.crit_target == id ? other.crit_mult : 1)
				
				switch(object_index) {
					
					case obj_enemy_basic: _dam *= other.dmg_mod_basic break
					
					case obj_enemy_strong: _dam *= other.dmg_mod_strong break
					
				}
				
				hp -= _dam
				
				if (hp <= 0) then {
					
					_this_died = true
					
					global.coins += coin_val
					
					instance_destroy()
					
				}
				
			}
			
			fun_give_exp(owner, obj_portal.cur_scale * ( _this_died ? 0.55 : 0.05 ))
			
			if _this_died then {
				
				owner.kills++
				target = noone
				
			}
			
			if (random(99) > chance_peirce) then {//fail
				
				instance_destroy()
				break
				
			} else {
				
				dmg *= damage_degrade
				chance_peirce -= chance_peirce_degrade
				
				continue
				
			}
			
		}
		
	}
	
	i++
	
}

#endregion lets try that again

image_angle = direction