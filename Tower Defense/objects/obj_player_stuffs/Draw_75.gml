
if (state == STATES.IN_GAME_TOWER_MENU) then {
	
	var _mouse_gui_x = device_mouse_x_to_gui(0) //window_mouse_get_x()
	var _mouse_gui_y = device_mouse_y_to_gui(0)
	
	with chosen_tower {
			
		draw_set_font(FNT_DRAC)
		
		#region menu
		
		var _border = 16
		var _2border = _border*2
		var _3border = _border*3
		
		var _gui_w = display_get_gui_width()
		var _gui_h = display_get_gui_height()
		
		
		var _menu_x = _gui_w - (_gui_w/2) //half the damn screen lol
		var _menu_w = _gui_w - _menu_x
		
		var _menu_y = 0
		
		//draw backing menu
		draw_sprite_stretched(spr_menu_bases, 0, _menu_x-_border, _menu_y-_border, _menu_w+_2border, _gui_h+_2border)
		
		var _c = c_black
		draw_text_color(_menu_x, _menu_y, name, _c, _c, _c, _c, 1)
		draw_text_color(_menu_x, _menu_y+32, string("XP: {0}/{1} Level: {2}/{3}", xp, xp_to_level, level, level_max), _c, _c, _c, _c, 1)
		draw_text_color(_menu_x, _menu_y+64, string("Upgrades: {0}/{2} Cost: {1}", upgrade, upgrade_cost, upgrade_max), _c, _c, _c, _c, 1)
		
		switch(object_index){
			
			case obj_tower_rock_thrower:
			#region rock thrower stats
			
			draw_text_color(_menu_x, _menu_y+96, string("Damage: {0} ATK SPD: {1}", damage, attack_speed), _c, _c, _c, _c, 1)
			draw_text_color(_menu_x, _menu_y+128, string("Range: {0} Peirce: {1}", range, bullet_peirce), _c, _c, _c, _c, 1)
			
			#endregion rock thrower stats
			break
			
		}
		
		#region upgrade button
		
		draw_sprite_stretched(spr_menu_bases, 0, _menu_x-_border, _gui_h-32-_border, 128+_2border, 32+_2border)
		draw_text_color(_menu_x, _gui_h-32, "Upgrade", _c, _c, _c,_c, 1)
		
		//draw_rectangle(_menu_x, _gui_h-32, _menu_x+128, _gui_h, true)
		
		if (other.mouse_left and global.coins >= upgrade_cost) then {
			
			if (point_in_rectangle(_mouse_gui_x, _mouse_gui_y, _menu_x, _gui_h-32, _menu_x+128, _gui_h)) then {
				
				alarm[0] = 1
				global.coins -= upgrade_cost
				upgrade++
				fun_upgrade()
				
			}
			
		}
		
		#endregion upgrade button
		
		#region target button
		
		draw_sprite_stretched(spr_menu_bases, 0, _menu_x+128, _gui_h-32-_border, 128+_3border, 32+_2border)
		
		var _findstring = ""
		
		switch(find){
			
			case FIND.FIRST: _findstring = "First" break
			case FIND.LAST: _findstring = "Last" break
			case FIND.NEAR: _findstring = "Near" break
			case FIND.FAR: _findstring = "Far" break
			case FIND.STRONG: _findstring = "Strong" break
			case FIND.WEAK: _findstring = "Weak" break
			case FIND.RANDOM: _findstring = "Random" break
			
		}
		
		draw_text_color(_menu_x+128+_border, _gui_h-32, _findstring, _c, _c, _c, _c, 1)
		
		//draw_rectangle(_menu_x+128, _gui_h-32, _menu_x+256+_3border, _gui_h, true)
		
		if (other.mouse_left and point_in_rectangle(_mouse_gui_x, _mouse_gui_y, _menu_x+128, _gui_h-32, _menu_x+256+_3border, _gui_h)) then {
			
			find++
			
			find = ( find > FIND.RANDOM ? FIND.FIRST : find )
			
		}
		
		#endregion target button
		
		#endregion menu
		
		draw_set_font(-1)
			
	}
	
}