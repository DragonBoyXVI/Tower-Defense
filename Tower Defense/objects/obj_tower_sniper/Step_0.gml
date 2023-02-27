
switch(state) {
	
	case 0:
	#region look 4 target
	
	fun_tower_get_target()
	
	#endregion look 4 target
	break
	
	case 1:
	#region attacking
	
	if (instance_exists(target) and point_distance(truex, truey, target.x, target.y) <= range_true) then {
		
		var _tdir = fun_rotate_to_point(truex, truey, target.x, target.y, rotate_speed)
		
		if (attack_cooldown <= 0 and abs(angle_difference(direction, _tdir)) <= rotate_leeway) then {
			
			attack_cooldown += fun_attack_cooldown(attack_speed)
			
			with instance_create_depth(gunx, guny,  depth-1, obj_bullet) {
				
				owner = other.id
				
				sprite_index = spr_bullet_real
				image_xscale = 1.4
				image_yscale = 2 - image_xscale
				
				fun_copy_multis()
				
				dmg = other.damage
				spd = fun_other_bullet_speed()
				
				rotate_speed = 0
				
				chance_peirce = other.bullet_peirce
				chance_peirce_degrade = other.bullet_peirce_degrade
				
				damage_degrade = other.bullet_peirce_damage_degrade
				
				crit_target = other.target
				
				target = noone
				
				direction = ( (target and instance_exists(target)) ? point_direction(x, y, target.x, target.y) : other.direction) + random_range( -other.aim_offset, other.aim_offset )
				
				effect_create_above(ef_spark, x+lengthdir_x(32, other.direction), y+lengthdir_y(32, other.direction), 0.1, c_white)
							
			}
			
			gun_xoff = 3
			gun_xscale = 0.8
			gun_yscale = 1.1
			
		}
		
	} else {
		
		target = noone
		state = 0
		
	}
	
	#endregion attacking
	break
	
}