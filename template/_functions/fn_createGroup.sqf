//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

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
	systemChat (format ["EP_fnc_createGroup: %1 is not a valid parameter! Expected side or group.", _spawnRef]);
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
	_precisePos		// Precise position placement
] call BIS_fnc_spawnGroup;

[_newGroup, _skillParams] call EP_fnc_setAISkill;

private _returnedGroup = grpNull;
if (_joinGroup) then {
	// Assign vehicles to existing group
	{ _spawnRef addVehicle _x } forEach ([_newGroup] call BIS_fnc_groupVehicles);
	(units _newGroup) joinSilent _spawnRef;
	_returnedGroup = _spawnRef;
} else {
	_newGroup deleteGroupWhenEmpty true;
	_returnedGroup = _newGroup;
};

_returnedGroup
