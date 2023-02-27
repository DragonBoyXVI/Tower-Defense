
switch(state) {
	
	case 0:
	#region look for a target
	
	fun_tower_get_target()
	
	#endregion look for a target
	break
	
	case 1:
	#region attacking a target
	
	if (instance_exists(target) and point_distance(truex, truey, target.x, target.y) <= range_true) then {
		
		var _tdir = fun_rotate_to_point(truex, truey, target.x, target.y, rotate_speed)
		
		if (attack_cooldown <= 0 and abs(angle_difference(direction, _tdir)) <= rotate_leeway) then {
			
			if (sprite_index != -1 and floor(image_index) < 3) then event_perform(ev_other, ev_user0)
			
			saved_target = target
			
			sprite_index = spr_rock_thrower_arm
			image_index = 0
			
			attack_cooldown += fun_attack_cooldown(attack_speed)
			
		}
		
	} else {
		
		target = noone
		state = 0
		
	}
	
	#endregion attacking a target
	break
	
}