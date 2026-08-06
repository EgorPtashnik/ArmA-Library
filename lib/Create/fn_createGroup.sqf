#include "..\constants.hpp";

params [
	"_position",
	"_spawnRef",
	"_classes",
	["_skillParams", []],
	["_relPositions", []],
	["_direction", 0],
	["_ranks", []],
	["_ammo", []],
	["_randControls", [-1, 1]],
	["_precisePos", true]
];

if !(_spawnRef isEqualType grpNull || _spawnRef isEqualType sideUnknown) exitWith {
	systemChat (format ["EP_fnc_createGroup: %1 is not a valid parameter! Expected side or group.", _side]);
};

private _pos = [];
private _side = sideUnknown;
private _joinGroup = false;

if (_position isEqualType [] && (count _position) == 2) then {
	private _ref = _position # 0;
	private _radius = _position # 1;
	_pos = [_ref, _radius] call EP_fnc_getRandomPosition;
} else {
	_pos = _position call EP_fnc_getPosition;
};

if (_spawnRef isEqualType grpNull) then {
	_side = side _spawnRef;
	_joinGroup = true;
} else {
	_side = _spawnRef;
};

private _newGroup = [
	_pos, 			// Spawn positions
	_side,			// Group's side
	_classes,		// Assets to be spawned
	_relPositions,  // Relative positions
	_ranks,			// Ranks
	[],				// Skill range
	_ammo,			// Ammo range 0..1 [min,max]
	_randControls,	// Random controls [minUnits, chance to spawn each add unit in range 0..1]
	_direction,		// Direction
	_precisePos,	// Precise position placement
] call BIS_fnc_spawnGroup;

{
	_x setSkill ( _sideParams getOrDefault ["SKILL", EP_MISSION_DEFAULT_SKILL] );
	_x setSkill ["aimingAccuracy", (_sideParams getOrDefault ["AIM", EP_MISSION_DEFAULT_AIMING_ACCURACY])];
	_x setSkill ["aimingShake", (_sideParams getOrDefault ["AIM_SHAKE", EP_MISSION_DEFAULT_AIMING_SHAKE])];
	_x setSkill ["aimingSpeed", (_sideParams getOrDefault ["AIM_SPEED", EP_MISSION_DEFAULT_AIMING_SPEED])];
	_x setSkill ["spotDistance", (_sideParams getOrDefault ["SPOT", EP_MISSION_DEFAULT_SPOT_DISTANCE])];
	_x setSkill ["spotTime", (_sideParams getOrDefault ["SPOT_TIME", EP_MISSION_DEFAULT_SPOT_TIME])];
	_x setSkill ["courage", (_sideParams getOrDefault ["COURAGE", EP_MISSION_DEFAULT_COURAGE])];
	_x setSkill ["reloadSpeed", (_sideParams getOrDefault ["RELOAD", EP_MISSION_DEFAULT_RELOAD_SPEED])];
	_x setSkill ["commanding", (_sideParams getOrDefault ["COMMAND", EP_MISSION_DEFAULT_COMMANDING])];
	_x allowFleeing (_sideParams getOrDefault ["FLEEING", EP_MISSION_DEFAULT_FLEEING]);
} forEach units _newGroup;

private _returnedGroup = grpNull;
if (_joinGroup) then {
	// Assign vehicles to existing group
	{ _x joinSilent _spawnRef } forEach units _newGroup;
	{ _spawnRef addVehicle _x } forEach ([_newGroup] call BIS_fnc_groupVehicles);
	_returnedGroup = _spawnRef;
} else {
	_newGroup deleteGroupWhenEmpty true;
	_returnedGroup = _newGroup;
};

_return
