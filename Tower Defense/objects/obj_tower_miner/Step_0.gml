
switch(state) {
	
	case 0:
	#region look for target
	
	fun_tower_get_target()
	
	#endregion look for target
	break
	
	case 1:
	#region attacking
	
	if (instance_exists(target) and point_distance(truex, truey, target.x, target.y) <= range_true) then {
		
		var _tdir = fun_rotate_to_point(truex, truey, target.x, target.y, rotate_speed)
		
		if (attack_cooldown <= 0 and abs(angle_difference(direction, _tdir)) <= rotate_leeway) then {
			
			var _dmg = damage, _this_died = false
			
			with target {
				
				switch(object_index) {
					
					case obj_enemy_basic: _dmg *= other.dmg_mod_basic break
					case obj_enemy_strong: _dmg *= other.dmg_mod_strong break
					
				}
				
				hp -= _dmg
				
				if (hp <= 0) then {
					
					global.coins += coin_val
					
					_this_died = true
					
					instance_destroy()
					
				}
				
			}
			
			fun_give_exp(id, obj_portal.cur_scale * ( _this_died ? 0.55 : 0.5 ))
			
			attack_cooldown += fun_attack_cooldown( attack_speed * ( _this_died ? attack_bonus : 1 ) )
			
			sprite_index = spr_miner_attack
			image_index = 0
			
		}
		
	} else {
		
		target = noone
		state = 0
		
	}
	
	#endregion attacking
	break
	
}