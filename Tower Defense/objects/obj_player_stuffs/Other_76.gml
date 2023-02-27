var _type = event_data[? "event_type"]
var _message = event_data[? "message"]
var _elem_id = event_data[? "element_id"]

//layer_instance_get_instance()

if (_type == "sprite event") then {
	
	var _caller = layer_instance_get_instance(_elem_id), _caller_x = _caller.truex, _caller_y = _caller.truey
	
	switch(_message){
		
		case "rock_thrower_toss":
		#region
		
		with _caller event_perform(ev_other, ev_user0)
		
		#endregion
		break
		
	}
	
}