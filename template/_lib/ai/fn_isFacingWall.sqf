/* ----------------------------------------------------------------------------
Function: EP_fnc_isFacingWall

Description:
    Checks if an object is facing a wall within a given direction, distance, and height.

Parameters:
    0: _object (Object) - Unit or object to check.
    1: _direction (Scalar) - Direction (0-360).
    2: _distance (Scalar, optional) - Detection distance (default: 15m).
    3: _height (Scalar, optional) - Height offset (default: 0m).

Example:
    [_unit, getDir _unit] call EP_fnc_isFacingWall

Returns:
    Boolean - True if facing a wall, false otherwise.
---------------------------------------------------------------------------- */

private ["_pos","_dis","_count","_intersects"];

_o = _this select 0;
_pos = getPos _o;
_posASL = if (_o isKindOF "CAMANBASE") then [{eyePos _o},{GetPosASL (_o)}];
_dir = _this select 1;
_dis = if (count _this > 2) then [{_this select 2},{15}];
_height = if (count _this > 3) then [{_this select 3},{0}];

_relpos = [[_pos select 0,_pos select 1,(_pos select 2) + _height], _dis, _dir] call BIS_fnc_relPos;

_intersects = lineIntersectsObjs [_posASL,ATLTOASL _relpos];
if (count _intersects > 0 && {(({(_x isKindOf "HouseBase" || _x isKindOf "BagBunker_base_F")} count _intersects) > 0)}) then [{true},{false}];