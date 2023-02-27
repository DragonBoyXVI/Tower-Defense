/// @description The Rock is thrown

with instance_create_depth(truex + lengthdir_x(16, direction-90), truey-8 + lengthdir_y(16, direction-90), depth-1, obj_bullet) {
	
	owner = other.id
	
	sprite_index = spr_rock_thrower_rocks
	image_index = irandom(2)
	image_speed = 0
	
	fun_copy_multis()
	
	dmg = other.damage
	spd = fun_other_bullet_speed()
	
	rotate_speed = other.bullet_rotation
	
	chance_peirce = other.bullet_peirce
	chance_peirce_degrade = other.bullet_peirce_degrade
	
	damage_degrade = other.bullet_peirce_damage_degrade
	
	target = other.saved_target
	
	direction =  other.direction //( (target and instance_exists(target)) ? point_direction(x, y, target.x, target.y) : other.direction) //cant use other.direction if bullet does not spawn at truex, truey
	
}

saved_target = noone

//attack_cooldown += fun_attack_cooldown(attack_speed)