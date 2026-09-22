/* ----------------------------------------------------------------------------
Function: EP_fnc_isFacingWall

Description:
    Checks if an object is facing a wall within a given direction, distance, and height.

Parameters:
    1. Unit or object to check: <OBJECT>
    2. Direction to check: <NUMBER>, 0-360
    3. (15) Detection distance: <NUMBER>
	4. (0) Height offset: <NUMBER>

Returns:
    <BOOL> : TRUE if facing a wall, FALSE otherwise.

Example:
    [EP_Unit, getDir EP_Unit] call EP_fnc_isFacingWall

Author:
	EP
---------------------------------------------------------------------------- */
params [
	"_object",
	"_dir",
	["_dis", 15],
	["_height", 0]
]

private _pos = getPos _object;
private _posASL = if (_object isKindOf "CAMANBASE") then [{eyePos _object}, {getPosASL _object}];
private _relPos = [[_pos # 0, _pos # 1, (_pos # 2) + _height], _dis, _dir] call BIS_fnc_relPos;
private _intersects = lineIntersectsObjs [_posASL, ATLtoASL _relPos];

private _result = false;
if (count _intersects > 0 && {({_x isKindOf "HouseBase" || _x isKindOf "BagBunker_base_F"} count _intersects) > 0}) then {
	_result = true;
};

_result
