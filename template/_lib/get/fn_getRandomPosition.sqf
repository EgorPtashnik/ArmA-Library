/* ----------------------------------------------------------------------------
Function: EP_fnc_getRandomPosition

Description:
    Returns a random position around a reference point, within a radius and
    an optional directional cone.

Parameters:
    0: _ref (Position, Object, Array or Group) - Reference point.
    1: _radius (Number, optional) - Maximum distance from the reference. Default 0.
    2: _direction (Number, optional) - Center direction of the cone. Default 0.
    3: _angle (Number, optional) - Width of the directional cone. Default 360 (full circle).

Example:
    [player, 50] call EP_fnc_getRandomPosition

Returns:
    Array - The random position.
---------------------------------------------------------------------------- */

params [
    "_ref",
    ["_radius", 0],
    ["_direction", 0],
    ["_angle", 360]
];

private _position = _ref call EP_fnc_getPosition;
private _doResize = _position isEqualTypeArray [0,0];

_position = _position getPos [_radius * sqrt random 1, _direction - 0.5*_angle + random _angle];

if (_doResize) then {
    _position resize 2;
};

_position
