/* ----------------------------------------------------------------------------
Function: EP_fnc_showObjects

Description:
    Shows or hides object(s) by toggling simulation, visibility, captive state
    and damage handling.

Parameters:
    0: _ref (String, Group, Object, or Array) - Mission layer name, group (uses its units),
        object, or array of objects to show/hide.
    1: _show (Boolean, optional) - Show (true) or hide (false) the object(s). Default true.

Example:
    ["HiddenCrates", false] call EP_fnc_showObjects

Returns:
    Array of Objects - The affected objects.
---------------------------------------------------------------------------- */

params [
	"_ref",
	["_show", true]
];

private _objects = [];
switch (typeName _ref) do {
	case "STRING"	: { _objects = (getMissionLayerEntities _ref # 0) };
	case "GROUP"	: { _objects = units _ref };
	case "ARRAY"	: { _objects = _ref };
	case "OBJECT"	: { _objects = [_ref] };
	default			  { systemChat (format ["EP_fnc_showObjects: %1 is not a valid parameter!", typeName _ref]) };
};

{
	private _veh = vehicle _x;
	_veh enableSimulation _show;
	_veh hideObject !_show;
	_veh setCaptive !_show;
	_veh allowDamage _show;
} forEach _objects;

_objects
