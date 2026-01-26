/**
	ep_fnc_getPos

	FEATURE
	Get position from various types of input (position, object, group, marker)

	RETURNS
	position (ARRAY)

	USAGE
	target call ep_fnc_getPos;

	PARAMETERS
	M|1. Target (marker, group, object, position)
*/

private ["_pos"];

switch (typeName _this) do {
	case "STRING": 	{ _pos = getMarkerPos _this };
	case "GROUP": 	{ _pos = getPos leader _this };
	case "OBJECT": 	{ _pos = getPos _this };
	case "ARRAY": 	{ _pos = _this };
	default: 		{ ["ep_fnc_getPos DBG:", _this ,"is not a valid parameter to get position!"] call ep_fnc_dbgLog };
};

_pos