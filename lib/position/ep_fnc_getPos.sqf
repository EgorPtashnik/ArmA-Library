private ["_pos"];

switch (typeName _this) do {
	case "STRING": {_pos = getMarkerPos _this};
	case "GROUP": {_pos = getPos leader _this};
	case "OBJECT": {_pos = getPos _this};
	case "ARRAY": {_pos = _this};
	default {["ep_fnc_getPos DBG:", _this ,"is not a valid parameter to get position!"] call ep_fnc_debugText};
};

_pos