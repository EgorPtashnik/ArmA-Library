/* ----------------------------------------------------------------------------
Function: EP_fnc_getRandomPositionArea

Description:
    Returns a random position uniformly distributed inside (or, optionally,
    along the perimeter of) a rectangular or elliptical area/zone/trigger.

Parameters:
    0: _zoneReference (Array, optional) - Zone reference accepted by BIS_fnc_getArea
        (e.g. trigger, marker name, or area array). Default [].
    1: _perimeter (Boolean, optional) - Return a position on the area's perimeter instead of inside it. Default false.

Example:
    ["mk_area", false] call EP_fnc_getRandomPositionArea

Returns:
    Array - The random position, or [] if the area reference is invalid.
---------------------------------------------------------------------------- */

params [
    ["_zoneReference", []],
    ["_perimeter", false]
];
private _area = _zoneReference call BIS_fnc_getArea;

if (_area isEqualTo []) exitWith {[]};

_area params [
	"_center",
	"_a",
	"_b",
	["_angle", 0],
	["_isRect", false]
];

private _posVector = [0,0,0];

if (_isRect) then {
    private _2a = _a*2;
    private _2b = _b*2;

    if (_perimeter) then {
        private _rho = random (4*(_a + _b));

        private _x1 = (_rho min _2a);
        private _y1 = ((_rho - _x1) min _2b) max 0;
        private _x2 = ((_rho - _x1 - _y1) min _2a) max 0;
        private _y2 = ((_rho - _x1 - _y1 - _x2) min _2b) max 0;
        _posVector = [(_x1 - _x2) - _a, (_y1 - _y2) - _b, 0];
    } else {
        _posVector = [random(_2a) - _a, random(_2b) - _b, 0];
    };
} else {
    // Generate point on circle of R=1
    private _rho = [random 1, 1] select _perimeter;
    private _phi = random 360;

    // Scale circle to dimensions of the ellipse
    private _x = sqrt(_rho) * cos(_phi);
    private _y = sqrt(_rho) * sin(_phi);

    _posVector = [_x * _a, _y * _b, 0];
};

_posVector = [_posVector, -_angle] call BIS_fnc_rotateVector2D;

_center vectorAdd _posVector
