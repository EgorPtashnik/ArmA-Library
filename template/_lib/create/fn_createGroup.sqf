/* ----------------------------------------------------------------------------
Function: EP_fnc_createGroup

Description:
    Spawns a new AI group (or adds units to an existing group) via
    BIS_fnc_spawnGroup, then applies skill settings to the spawned units.

Parameters:
    0: _position (Position, Object, Array or Group, or [Reference, Radius]) - Spawn location, or a
        [reference, radius] pair to spawn at a random position around the reference.
    1: _spawnRef (Group or Side) - Group to join units to, or a side to create a new group for.
    2: _classes (Array) - Unit classes to spawn.
    3: _skillParams (Array, optional) - Skill settings passed to EP_fnc_setAISkill. Default [].
    4: _relPositions (Array, optional) - Relative positions for spawned units. Default [].
    5: _direction (Number, optional) - Spawn direction. Default 0.
    6: _ranks (Array, optional) - Ranks for spawned units. Default [].
    7: _ammo (Array, optional) - Ammo range [min, max]. Default [].
    8: _randControls (Array, optional) - [minUnits, chance per additional unit]. Default [-1, 1].
    9: _precisePos (Boolean, optional) - Use precise position placement. Default true.

Example:
    [getMarkerPos "mk_spawn", east, ["O_Soldier_F", "O_Soldier_F"]] call EP_fnc_createGroup

Returns:
    Group - The resulting group (existing or newly created).
---------------------------------------------------------------------------- */

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

//Validate parameter count
if ((count _this) < 3) exitWith { debugLog "EP_fnc_createGroup: Function requires at least 3 parameters!"; grpNull };

// Validate spawn reference parameters
if !(_spawnRef isEqualType grpNull || _spawnRef isEqualType sideUnknown) exitWith { debugLog "EP_fnc_createGroup: Spawn reference (1) must be a side or a group."; grpNull };

private _pos = [];
private _side = sideUnknown;
private _joinGroup = false;

//Get position
if (_position isEqualType [] && (count _position) == 2) then {
	private _ref = _position # 0;
	private _radius = _position # 1;
	_pos = [_ref, _radius] call EP_fnc_getRandomPosition;
} else {
	_pos = _position call EP_fnc_getPosition;
};

//Determine to join group or create a new one
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
