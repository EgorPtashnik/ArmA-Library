/* ----------------------------------------------------------------------------
Function: EP_fnc_collectVariables

Description:
    Collects sequentially variable values by their previx (e.g. EP_Unit_1, EP_Unit_2, EP_Unit_3).
	Can collect in reversed order 

	Filters out null variables

Parameters:
    1: Variables prefix: <STRING>, [<STRING>...]

Optional:
    2: (true) Return in revered order: <BOOL>

Returns:
	[<VAR>...] : Array of collected variable values

Example:
    ["EP_Unit"] call EP_fnc_collectVariables

Author:
	EP
---------------------------------------------------------------------------- */
params [
	"_varPrefixes",
	["_reversed", false]
];

if !(_this isEqualType "" || _this isEqualType []) exitWith {
    systemChat format ["[LOG] %1(%2): %3", __FILE__, __LINE__, "EP_fnc_collectVariables: Cannot get variables! Parameter must be <STRING> or [<STRING>...]!"];
};

if (_this isEqualType "") then {
	_this = [_this];
};


// Collect variable values
private ["_array", "_varName", "_VarValue"];
_array = [];
{
	for "_i" from 1 to 128 do {
		_varName = format["%1_%2", _x, _i];
		_varValue = missionNamespace getVariable _varName;

		if (isNil "_varValue" || {isNull _varValue}) exitWith {};

		_array pushBack _varValue;
	};
} forEach _this;

if (_reversed) then {
	reverse _array;
};

_array
