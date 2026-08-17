#define EP_DEFAULT_SKILL 0.5
#define EP_DEFAULT_AIM 0.2
#define EP_DEFAULT_AIM_SHAKE 0.2
#define EP_DEFAULT_AIM_SPEED 0.2
#define EP_DEFAULT_AIM_SPOT 0.5
#define EP_DEFAULT_AIM_SPOT_TIME 0.25
#define EP_DEFAULT_COURAGE 1
#define EP_DEFAULT_RELOAD 0.5
#define EP_DEFAULT_COMMAND 0.5
#define EP_DEFAULT_FLEEING 0

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
	_x setSkill ( _params getOrDefault ["SKILL", EP_DEFAULT_SKILL] );
	_x setSkill ["aimingAccuracy", 	(_params getOrDefault ["AIM", 		EP_DEFAULT_AIM])];
	_x setSkill ["aimingShake", 	(_params getOrDefault ["AIM_SHAKE", EP_DEFAULT_AIM_SHAKE])];
	_x setSkill ["aimingSpeed", 	(_params getOrDefault ["AIM_SPEED", EP_DEFAULT_AIM_SPEED])];
	_x setSkill ["spotDistance", 	(_params getOrDefault ["SPOT", 		EP_DEFAULT_AIM_SPOT])];
	_x setSkill ["spotTime", 		(_params getOrDefault ["SPOT_TIME", EP_DEFAULT_AIM_SPOT_TIME])];
	_x setSkill ["courage", 		(_params getOrDefault ["COURAGE", 	EP_DEFAULT_COURAGE])];
	_x setSkill ["reloadSpeed", 	(_params getOrDefault ["RELOAD", 	EP_DEFAULT_RELOAD])];
	_x setSkill ["commanding", 		(_params getOrDefault ["COMMAND",	EP_DEFAULT_COMMAND])];
	_x allowFleeing 				(_params getOrDefault ["FLEEING", 	EP_DEFAULT_FLEEING]);
} forEach _units;

_ref