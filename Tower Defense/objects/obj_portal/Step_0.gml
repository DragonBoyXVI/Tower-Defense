


switch(state) {
	
	case 0:
	#region waiting to spawn next wave
	
	if (time_to_next_wave <= 0) then {
		
		wave++
		cur_scale += scale_amt
		
		if (wave < array_length(wave_funs)) then {
			
			var _array_0, _array_1, _array_final
			
			_array_0 = array_create(irandom(10*cur_scale), [choose(obj_enemy_strong, obj_enemy_basic), 10])
			_array_1 = array_create(irandom(10*cur_scale), [choose(obj_enemy_strong, obj_enemy_basic), 10])
			
			_array_final = array_shuffle( array_concat(_array_0, _array_1) )
			
			array_push(wave_funs, _array_final)
			array_copy(array_creating, 0, wave_funs[wave], 0, array_length(wave_funs[wave]))
			state = 1
			
		}
		
	} else {
		
		time_to_next_wave -= global.timeslow * ( instance_exists(obj_enemy_parent) ? 1 : 3 )
		
	}
	
	#endregion waiting to spawn next wave
	break
	
	case 1:
	#region making units
	
	if (wait_to_create > 0) then {
		
		wait_to_create -= global.timeslow
		
	} else {
		
		if (array_length(array_creating) > 0) then {
			
			var _this = array_pop(array_creating)
			instance_create_layer(x, y, "Instances", _this[0])
			wait_to_create += _this[1]
			
		} else {
			
			state = 2
			time_to_next_wave += room_speed*instance_number(obj_enemy_parent)
			
		}
	}
	
	#endregion making units
	break
	
	case 2:
	#region waiting
	
	if (time_to_next_wave > 0) then {
		
		time_to_next_wave -= global.timeslow
		
	} else {
		
		state = 0
		
	}
	
	#endregion waiting
	break
	
}
