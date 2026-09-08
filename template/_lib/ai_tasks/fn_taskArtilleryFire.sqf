//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_arti",
	"_target",
	"_rounds",
	[ "_magType", objNull ],
	[ "_sleepRange", [0.5, 1, 1.5] ]
];

_target = _target call EP_fnc_getPosition;

// Get vehicles from group if group is passed
if (_arti isEqualType grpNull) then {
	_arti = [_arti, false] call BIS_fnc_groupVehicles;
};

// Get first magazine type if not specified
if (isNull _magType) then { 
	_magType = magazines (_arti # 0) # 0;
};

// Check if target is in range of artillery
private _isInRange = _target inRangeOfArtillery [_arti, _magType];
if (!_isInRange) exitWith { false };

// Fire!
{
	_x doArtilleryFire [ _target, _magType, _rounds ];
	sleep ( selectRandom _sleepRange );
} forEach _arti;

_arti
