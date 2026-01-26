/**
	ep_fnc_getGroup

	FEATURE
	Get group from unit or group or units

	RETURNS
	group

	USAGE
	group or unit or units call ep_fnc_getGroup;

	PARAMETERS
	M|1. Group (group) or unit (object) or units (array)
*/

switch (typeName _this) do {

	case "GROUP": 	{_this = _this};

	case "OBJECT": 	{_this = group _this};

	case "ARRAY": 	{_this = group (_this # 0)};

	default: 		{ ["ep_fnc_getGroup DBG:", _this ,"is not a valid parameter to get group!"] call ep_fnc_dbgLog };

};

_this
