/* ----------------------------------------------------------------------------
Function: EP_fnc_createUnit

Description:
    Creates a single unit within a group at the group leader's position, a
    given position, or a random position around a marker, using createUnit.

Parameters:
    0: _group (Group or Object) - The group to create the unit in.
    1: _type (String or Array) - Unit class, or an array of classes to pick one from at random.
    
    Optional (passed as trailing arguments in any order):
    - Special (String) - "NONE", "CAN_COLLIDE", or "CARGO".
    - Radius (Number) - Placement radius around the position.
    - Position (String, Position, Object, Array or Group) - Marker name or position to spawn at.

Example:
    [enemyGroup, "O_Soldier_F", "mk_spawn", 10] call EP_fnc_createUnit

Returns:
    Object - The created unit.
---------------------------------------------------------------------------- */

//Constants
private _unitSpecials =  ["NONE", "CAN_COLLIDE", "CARGO"];

//Function
params [
	"_group",
	"_type"
];


private _args = _this - [_group, _type];

_group = _group call EP_fnc_getGroup;
if (_type isEqualType []) then {
	_type = selectRandom _type;
};

private _position = [];
private _radius = 0;
private _markers = [];
private _special = "NONE";

// Spawn position will be group leader if exist
if ( (units _group) findIf { alive _x } != -1 ) then {
	_position = _group call EP_fnc_getPosition;
};

{

	if (_x in _unitSpecials)	then { _special = _x; continue };
	if (_x isEqualType 0) 					then { _radius = _x; continue };

	if (_x isEqualType "") 					then {
		_markers = _x call EP_fnc_collectMarkers;
		_position = (_markers # 0) call EP_fnc_getPosition;
		if (count _markers == 1) then {	_markers = [] };
		continue
	} else {
		_position = _x call EP_fnc_getPosition;
		continue
	};

} forEach _args;


private _unit = _group createUnit [_type, _position, _markers, _radius, _special];

_unit
