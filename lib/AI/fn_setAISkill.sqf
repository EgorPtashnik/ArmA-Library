#include "..\constants.hpp";

params [
	"_ref",
	["_skillParams", []]
];

private _units = [];

switch (typeName _ref) do {
	case "GROUP"	: { _units = units _ref };
	case "ARRAY"	: { _units  = _ref };
	case "OBJECT"	: { _units = [_ref] };
	default			  { systemChat "EP_fnc_setAISkill: Invalid parameter" };
};

private _params = createHashMapFromArray _skillParams;

{
	_x setSkill ( _params getOrDefault ["SKILL", EP_MISSION_DEFAULT_SKILL] );
	_x setSkill ["aimingAccuracy", (_params getOrDefault ["AIM", EP_MISSION_DEFAULT_AIMING_ACCURACY])];
	_x setSkill ["aimingShake", (_params getOrDefault ["AIM_SHAKE", EP_MISSION_DEFAULT_AIMING_SHAKE])];
	_x setSkill ["aimingSpeed", (_params getOrDefault ["AIM_SPEED", EP_MISSION_DEFAULT_AIMING_SPEED])];
	_x setSkill ["spotDistance", (_params getOrDefault ["SPOT", EP_MISSION_DEFAULT_SPOT_DISTANCE])];
	_x setSkill ["spotTime", (_params getOrDefault ["SPOT_TIME", EP_MISSION_DEFAULT_SPOT_TIME])];
	_x setSkill ["courage", (_params getOrDefault ["COURAGE", EP_MISSION_DEFAULT_COURAGE])];
	_x setSkill ["reloadSpeed", (_params getOrDefault ["RELOAD", EP_MISSION_DEFAULT_RELOAD_SPEED])];
	_x setSkill ["commanding", (_params getOrDefault ["COMMAND", EP_MISSION_DEFAULT_COMMANDING])];
	_x allowFleeing (_params getOrDefault ["FLEEING", EP_MISSION_DEFAULT_FLEEING]);
} forEach _units;

_ref