wave = -1
time_to_next_wave = 5
state = 0

scale_amt = 0.125
cur_scale = 1 - scale_amt

wait_to_create = 0

direction = random(360)

//array of functions
wave_funs = [
	
]

array_creating = [ //enemy object, time to next foe

]

path_all = -1
path_basic = -1

switch(room) {
	
	case rm_map_0:
	#region
	
	path_all = pth_test
	
	wave_funs = [
		
		array_create(irandom(100), [choose(obj_enemy_basic, obj_enemy_strong), 10]),
		
	]
	
	#endregion
	break
	
}

ds_grid_resize(global.tower_grid, room_width/GRIDSIZE_WIDTH, room_height/GRIDSIZE_HEIGHT)
ds_grid_clear(global.tower_grid, noone)

var _tiles = layer_tilemap_get_id("Tiles_1")
var _thistile = -1

var i = 0, j = 0
repeat(ds_grid_width(global.tower_grid)) {
	
	j = 0
	
	repeat(ds_grid_height(global.tower_grid)) {
		
		_thistile = tilemap_get_at_pixel(_tiles, i*GRIDSIZE_WIDTH+32, j*GRIDSIZE_HEIGHT+32)
		
		if _thistile == 2 then ds_grid_set(global.tower_grid, i, j, "This is a road tile")
		else if _thistile == 3 then ds_grid_set(global.tower_grid, i, j, "water")
		else if _thistile == 0 or _thistile == 4 then ds_grid_set(global.tower_grid, i, j, "void")
		// 1 is for ground
		
		j++
		
	}
	
	i++
	
}

//show_message(wave_funs)