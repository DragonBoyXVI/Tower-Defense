


#region 

switch(state) {
	
	case 0:
	#region looking for targets
	
	fun_tower_get_target()
	
	//if (target != noone) then event_perform(ev_step, ev_step_normal)
	
	#endregion looking for targets
	break
	
	case 1:
	#region attacking
	
	if (instance_exists(target) and point_distance(truex, truey, target.x, target.y) <= range_true) then {
		
		var _tdir = fun_rotate_to_point(truex, truey, target.x, target.y, rotate_speed)
		
		if ( attack_cooldown <= 0 and abs(angle_difference(direction, _tdir)) <= rotate_leeway) then {
			
			with instance_create_depth(truex, truey, depth-1 ,obj_bullet) {
				
				owner = other.id
				
				direction = other.direction
				
				fun_copy_multis()
				
				target = other.target
				can_hit = target
				
				dmg = other.damage
				
				spd = (other.bullet_speed * ((GRIDSIZE_HEIGHT+GRIDSIZE_WIDTH)/2))
				rotate_speed = other.bullet_rotation
				
				chance_peirce = other.bullet_peirce
				chance_peirce_degrade = other.bullet_peirce_degrade
				damage_degrade = other.bullet_peirce_damage_degrade
				
			}
			
			attack_cooldown += (60/attack_speed)/2
		}
		
	} else {
		
		target = noone
		state = 0
		fun_tower_get_target()
		//event_perform(ev_step, ev_step_normal)
		
	}
	
	#endregion attacking
	break
	
}

#endregion





/*

if (target and instance_exists(target) and distance_to_object(target) <= range_true) then {
	
	var _tdir = fun_rotate_to_point(truex, truey, target.x, target.y, rotate_speed)
	
	if (abs(angle_difference(direction, _tdir)) <= rotate_leeway and attack_cooldown <= 0) then {
		
		with instance_create_depth(truex, truey, depth-1 ,obj_bullet) {
			
			direction = other.direction
			
			dmg_mod_basic = other.dmg_mod_basic
			
			target = other.target
			can_hit = target
			
			dmg = other.damage
			
			spd = (other.bullet_speed * ((GRIDSIZE_HEIGHT+GRIDSIZE_WIDTH)/2))
			rotate_speed = other.bullet_rotation
			
		}
		
		attack_cooldown += (60/attack_speed)/2
		
	}
	
} else {
	
	target = noone
	fun_tower_get_target()
	
}