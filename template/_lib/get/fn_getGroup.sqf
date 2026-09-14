/* ----------------------------------------------------------------------------
Function: EP_fnc_getGroup

Description:
    Resolves a group reference to a Group, unwrapping a single-element array
    if necessary, via CBA_fnc_getGroup.

Parameters:
    0: _this (Group, Object, or Array) - Group reference to resolve.

Example:
    [player] call EP_fnc_getGroup

Returns:
    Group - The resolved group.
---------------------------------------------------------------------------- */

if (_this isEqualType []) then {
	_this = _this # 0;
};

private _group = _this call CBA_fnc_getGroup;

_group
