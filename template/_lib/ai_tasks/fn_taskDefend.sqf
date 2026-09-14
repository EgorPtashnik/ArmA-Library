/* ----------------------------------------------------------------------------
Function: EP_fnc_taskDefend

Description:
    Wrapper around CBA_fnc_taskDefend. Orders a group to defend an area,
    garrisoning nearby buildings and patrolling within a radius.

Parameters:
    0: _group (Group or Object) - The group to defend the area.
    1: _destination (Position, Object, Array or Group, optional) - Area to defend. Defaults to the group's current position.
    2: _radius (Number, optional) - Defence radius. Default 100.
    3: _threshold (Number, optional) - Minimum number of enemies to react to. Default 3.
    4: _patrol (Number, optional) - Fraction of units that patrol. Default 0.1.
    5: _hold (Number, optional) - Fraction of units that hold position. Default 0.

Example:
    [defGroup, getMarkerPos "objDefend", 150] call EP_fnc_taskDefend

Returns:
    Nothing.
---------------------------------------------------------------------------- */

params [
	"_group",
	["_destination", 0],
	["_radius", 100],
	["_threshold", 3],
	["_patrol", 0.1],
	["_hold", 0]
];

_group = _group call EP_fnc_getGroup;

if (_destination isEqualType 0) then {
	_destination = _group call EP_fnc_getPosition;
} else {
	_destination = _destination call EP_fnc_getPosition;
};

[_group, _destination, _radius, _threshold, _patrol, _hold] call CBA_fnc_taskDefend;
