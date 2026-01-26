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

private ["_grp"];

if (_this isEqualType []) then {_this = _this # 0};

_grp = _this call cba_fnc_getGroup;

_grp
