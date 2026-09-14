/* ----------------------------------------------------------------------------
Function: EP_fnc_getPosition

Description:
    Resolves a marker name, group, object, or position array to a position.

Parameters:
    0: _this (String, Group, Object, or Array) - Marker name, group (uses leader),
        object, or an already-resolved position array.

Example:
    "mk_spawn" call EP_fnc_getPosition

Returns:
    Array - The resolved position.
---------------------------------------------------------------------------- */

switch (typeName _this) do {
	case "STRING"	: { _this = getMarkerPos _this };
	case "GROUP"	: { _this = getPos leader _this };
	case "OBJECT"	: { _this = getPos _this };
	case "ARRAY"	: { _this = _this };

	default 		  { systemChat (format ["EP_fnc_getPosition: %1 is not a valid parameter!", _this]) };
};

_this
