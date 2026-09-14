/* ----------------------------------------------------------------------------
Function: EP_fnc_collectUnits

Description:
    Flattens a mixed list of groups, objects, arrays, and mission layer names
    into a single array of unit objects.

Parameters:
    0: _this (Group, Object, Array, or String, or an Array of any of these) - Source(s) of units.
        Strings are treated as mission layer names resolved via getMissionLayerEntities.

Example:
    [group1, someUnit, "EnemyLayer"] call EP_fnc_collectUnits

Returns:
    Array of Objects - The collected units.
---------------------------------------------------------------------------- */

if !(_this isEqualType []) then {
	_this = [_this];
};

private _units = [];
{
	switch (typeName _x) do {
		case "GROUP"	: { _units append (units _x) };
		case "OBJECT"	: { _units append [_x] };
		case "ARRAY"	: { _units append _x };
		case "STRING"	: { _units append (getMissionLayerEntities _x # 0) };
		default			  { systemChat "EP_fnc_collectUnits: Invalid incoming parameter!" };
	};
} forEach _this;

_units;
