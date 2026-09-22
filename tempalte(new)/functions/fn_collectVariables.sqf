/* ----------------------------------------------------------------------------
Function: EP_fnc_collectVariables

Description:
    Collects sequentially variable values by their previx (e.g. EP_Unit_1, EP_Unit_2, EP_Unit_3).
	Can collect in reversed order 

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

// Params check
if !(_this isEqualType "" || _this isEqualType []) exitWith {
    systemChat format ["[LOG] %1(%2): %3", __FILE__, __LINE__, "EP_fnc_collectVariables: Cannot get variables! Parameter must be <STRING> or <STRING>[]!"]}
	systemChat "EP_fnc_collectVariables: Must give variable prefix as String or Array!";
};

if (_this isEqualType "") then {
	_this = [_this];
};


// Collect variable values
private _array = [];
{
	for "_i" from 1 to 128 do {
		private _varName = format["%1_%2", _x, _i];
		private _varValue = missionNamespace getVariable _varName;

		if (isNil "_varValue") exitWith {};

		if (_reversed) then {
			_array pushBack _varValue;
		} else {
			_array append [_varValue];
		};
	};
} forEach _this;

(_array select {!isNull _x})
