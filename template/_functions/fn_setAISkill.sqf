//************************************************************************************************************
// CONSTANTS
//************************************************************************************************************

private _defaultSkill	 	= 0.5;
private _defaultAim			= 0.2;
private _defaultAimShake	= 0.2;
private _defaultAimSpeed	= 0.2;
private _defaultAimSpot		= 0.5;
private _defaultAimSpotTime	= 0.25;
private _defaultCourage		= 1;
private _defaultReload		= 0.5;
private _defaultCommanding	= 0.5;
private _defaultFleeing		= 0;

//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

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
	_x setSkill ( _params getOrDefault ["SKILL", _defaultSkill] );

	_x setSkill ["aimingAccuracy", 	(_params getOrDefault ["AIM", _defaultAim])];
	_x setSkill ["aimingShake", 	(_params getOrDefault ["AIM_SHAKE", _defaultAimShake])];
	_x setSkill ["aimingSpeed", 	(_params getOrDefault ["AIM_SPEED", _defaultAimSpeed])];
	_x setSkill ["spotDistance", 	(_params getOrDefault ["SPOT", _defaultAimSpot])];
	_x setSkill ["spotTime", 		(_params getOrDefault ["SPOT_TIME", _defaultAimSpotTime])];
	_x setSkill ["courage", 		(_params getOrDefault ["COURAGE", _defaultCourage])];
	_x setSkill ["reloadSpeed", 	(_params getOrDefault ["RELOAD", _defaultReload])];
	_x setSkill ["commanding", 		(_params getOrDefault ["COMMAND", _defaultCommanding])];
	_x allowFleeing 				(_params getOrDefault ["FLEEING", _defaultFleeing]);
} forEach _units;

_ref