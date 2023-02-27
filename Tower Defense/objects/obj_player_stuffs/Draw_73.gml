

#region manage global slow

if keyboard_check_pressed(ord("Y")) then target_time = 0
if keyboard_check_pressed(ord("U")) then target_time = 0.1
if keyboard_check_pressed(ord("I")) then target_time = 1
if keyboard_check_pressed(ord("O")) then target_time = 2
if keyboard_check_pressed(ord("P")) then target_time = 3

var _curtime = global.timeslow

if (_curtime != target_time) then {
	
	_curtime +=  sign(target_time - _curtime)/10 //round((lerp(_curtime, target_time, 0.25))*100)/100
	
}

global.timeslow = _curtime

#endregion manage global slow

#region move the camera

target_lens_size = clamp( target_lens_size + ( wheel_change_speed * ( wheel_up - wheel_down ) ), 1, 6 )

if (cur_lens_size != target_lens_size) then {
	
	fun_resize_camera()
	
}

x += move_speed * ( key_right - key_left )
y += move_speed * ( key_down - key_up )

x = clamp(x, 0, room_width)
y = clamp(y, 0, room_height)

#endregion move the camera

switch(state) {
	
	case STATES.IN_GAME_NOSELECT:
	#region no tower is selected and no tower is pending placment
	
	#region choosing a tower
	
	if (mouse_right) then {
		
		var _chosen = ds_grid_get(global.tower_grid, grid_mouse_x, grid_mouse_y)
		
		if (_chosen == noone or is_string(_chosen)) then {
			
			
			
		} else {
			
			state = STATES.IN_GAME_TOWER_MENU
			chosen_tower = _chosen
			chosen_x = grid_mouse_x
			chosen_y = grid_mouse_y
			
		}
		
	}
	
	#endregion choosing a tower
	
	#region place a tower with num keys
	
	if (key_one) then {
		
		state = STATES.IN_GAME_PLACE_TOWER_MENU
		pending_place = obj_tower_rock_thrower
		pending_sprite = spr_rock_thrower_head
		
	} else if (key_two) then {
		
		state = STATES.IN_GAME_PLACE_TOWER_MENU
		pending_place = obj_tower_miner
		pending_sprite = spr_miner_head
		
	} else if (key_three) then {
		
		state = STATES.IN_GAME_PLACE_TOWER_MENU
		pending_place = obj_tower_sniper
		pending_sprite = spr_sniper_boxes
		
	}
	
	#endregion place a tower with num keys
	
	#endregion no tower is selected and no tower is pending placment
	break
	
	case STATES.IN_GAME_PLACE_TOWER_MENU:
	#region a tower is pending placment
	
	draw_sprite_ext(pending_sprite, 0, grid_mouse_x*GRIDSIZE_WIDTH+32, grid_mouse_y*GRIDSIZE_HEIGHT+32, 1, 1, 0, c_white, 0.5)
	
	switch(pending_place) {
		
		case obj_tower_rock_thrower:
		#region
		
		draw_text(mouse_x, mouse_y, "costs 60 coins")
		
		if (mouse_left and ds_grid_get(global.tower_grid, grid_mouse_x, grid_mouse_y) == noone) then {
			
			if (global.coins >= 60) then {
				
				global.coins -= 60
				var _placed = instance_create_depth(grid_mouse_x*GRIDSIZE_WIDTH, grid_mouse_y*GRIDSIZE_HEIGHT, -5, pending_place)
				
				ds_grid_set(global.tower_grid, grid_mouse_x, grid_mouse_y, _placed)
				
			}
			
		}
		
		#endregion
		break
		
		case obj_tower_miner:
		#region
		
		draw_text(mouse_x, mouse_y, "costs 80 coins")
		
		if (mouse_left and ds_grid_get(global.tower_grid, grid_mouse_x, grid_mouse_y) == noone) then {
			
			if (global.coins >= 80) then {
				
				global.coins -= 80
				var _placed = instance_create_depth(grid_mouse_x*GRIDSIZE_WIDTH, grid_mouse_y*GRIDSIZE_HEIGHT, -5, pending_place)
				
				ds_grid_set(global.tower_grid, grid_mouse_x, grid_mouse_y, _placed)
				
			}
			
		}
		
		#endregion
		break
		
		case obj_tower_sniper:
		#region
		
		draw_text(mouse_x, mouse_y, "costs 110 coins")
		
		if (mouse_left and ds_grid_get(global.tower_grid, grid_mouse_x, grid_mouse_y) == noone) then {
			
			if (global.coins >= 110) then {
				
				global.coins -= 110
				var _placed = instance_create_depth(grid_mouse_x*GRIDSIZE_WIDTH, grid_mouse_y*GRIDSIZE_HEIGHT, -5, pending_place)
				
				ds_grid_set(global.tower_grid, grid_mouse_x, grid_mouse_y, _placed)
				
			}
			
		}
		
		#endregion
		break
		
		
		
	}
	
	
	if (mouse_right) then {
		
		state = STATES.IN_GAME_NOSELECT
		
	}
	
	#endregion a tower is pending placment
	break
	
	case STATES.IN_GAME_TOWER_MENU:
	#region selected tower for upgrades
	
	chosen_tower.fun_draw_range()
	
	if (mouse_right) then {
		
		state = STATES.IN_GAME_NOSELECT
		
	}
	
	#endregion selected tower for upgrades
	break
	
}

draw_sprite_ext(spr_pix, 0, x-4, y-8, 8, 8, 0, c_white, 0.5)