/* ----------------------------------------------------------------------------
Function: EP_fnc_clearWaypoints

Description:
    Clears all waypoints assigned to a group.

Parameters:
    _group (Group or Object) - The group or unit whose waypoints should be cleared.

Example:
    [group player] call EP_fnc_clearWaypoints

Returns:
    Group - The group that was processed.
---------------------------------------------------------------------------- */

private _group = _this call EP_fnc_getGroup;

_group call CBA_fnc_clearWaypoints;

_group
