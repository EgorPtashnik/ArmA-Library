/**
	ep_fnc_taskArtilleryFire

	FEATURE
	Task artillery vehicles to fire at a target position
	
	RETURNS
	false if target position is out of range for artillery, true otherwise

	USAGE
	[arti or group, target, roundsNumber] call ep_fnc_taskArtilleryFire;

	PARAMETERS
	M|1. Artillery Vehicles or Group
	M|2. Target (object, marker, position, group)
	M|3. Rounds count
	O|4. Magazine type to fire (Default objNull)
	O|5. Sleep range between firing vehicles (Default [0.5, 1, 1.5])
*/

params [
	"_arti", "_target", "_rounds",
	[ "_magType", objNull ],
	[ "_sleepRange", [0.5, 1, 1.5] ]
];

private [ "_isInRange" ];

_target = _target call ep_fnc_getPos;

//get vehicles from group if group is passed
if ((typeName _arti) == "GROUP") then { _arti = [_arti, false] call BIS_fnc_groupVehicles };

//get first magazine type if not specified
if (isNull _magType) then { _magType = magazines (_arti # 0) # 0 };

//check if target is in range of artillery
 _isInRange = _target inRangeOfArtillery [_arti, _magType];
if (!_isInRange) exitWith { false };

//fire!
{
	_x doArtilleryFire [ _target, _magType, _rounds ];
	sleep ( selectRandom _sleepRange );
} forEach _arti;

true
