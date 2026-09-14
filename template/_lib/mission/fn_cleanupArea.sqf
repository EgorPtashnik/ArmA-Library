/* ----------------------------------------------------------------------------
Function: EP_fnc_cleanupArea

Description:
    Deletes all objects within a radius of a position. If any deleted object
    had crew (e.g. was a vehicle that ejected its occupants), the cleanup is
    retried, up to 10 times, to catch newly-exposed objects.

Parameters:
    0: _position (Position, Object, Array or Group) - Center of the cleanup area.
    1: _radius (Number) - Cleanup radius.
    2: _execCounter (Number, optional) - Internal recursion counter. Default 0.

Example:
    [getMarkerPos "mk_cleanup", 100] call EP_fnc_cleanupArea

Returns:
    Nothing.
---------------------------------------------------------------------------- */

params [
	"_position",
	"_radius",
	["_execCounter", 0]
];

if (_execCounter > 10) exitWith {};

_execCounter = _execCounter + 1;

if !(_radius isEqualType 0) exitWith {};

_position = _position call EP_fnc_getPosition;

private _toDelete = nearestObjects [_position, [], _radius, true];
private _repeat = (_toDelete findIf { count crew _x > 0 } != -1);
{ deleteVehicle _x } forEach _toDelete;

if (_repeat) then {
	[_position, _radius, _execCounter] call EP_fnc_cleanupArea;
};