/* ----------------------------------------------------------------------------
Function: EP_fnc_taskAttack

Description:
    Clears the group's existing waypoints, re-enables PATH/MOVE AI on all units,
    then issues a Search-And-Destroy waypoint at the given destination with
    COMBAT behaviour and RED combat mode.

Parameters:
    0: _group (Group or Object) - The group (or a unit of the group) to command.
    1: _destination (Position, Object, Array, Marker or Group) - Target location of the attack.
    
    Optional (passed as trailing arguments, forwarded to EP_fnc_addWaypoint):
    - Any additional waypoint parameter supported by EP_fnc_addWaypoint.

Example:
    [enemyGroup, "objAttack"] call EP_fnc_taskAttack

Returns:
    Waypoint (Array) - [Group, Waypoint Index]
---------------------------------------------------------------------------- */

params [
	"_group",
	"_destination"
];

private _args = _this - [_group, _destination];

_group = _group call EP_fnc_getGroup;
_destination = _destination call EP_fnc_getPosition;

_group call EP_fnc_clearWaypoints;
{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;

private _waypoint = ([_group, _destination, "SAD", "COMBAT", "RED", -1] + _args) call EP_fnc_addWaypoint;

_waypoint
