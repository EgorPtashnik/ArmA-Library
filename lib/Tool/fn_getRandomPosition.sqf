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
